From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/4] pwm: add ChromeOS EC PWM driver
Date: Tue, 31 May 2016 16:55:07 -0700
Message-ID: <20160531235507.GA121799@google.com>
References: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
 <1464399556-17222-5-git-send-email-briannorris@chromium.org>
 <CAMHSBOWLqDEH2-V503szG3GXHPGBAXpzjU2J7Kdp__wXhUQOGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMHSBOWLqDEH2-V503szG3GXHPGBAXpzjU2J7Kdp__wXhUQOGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pwm@vger.kernel.org

Hi Gwendal,

Thanks for the review.

On Sat, May 28, 2016 at 10:02:33PM -0700, Gwendal Grignou wrote:
> On Fri, May 27, 2016 at 6:39 PM, Brian Norris <briannorris@chromium.org> wrote:
> > Use the new ChromeOS EC EC_CMD_PWM_{GET,SET}_DUTY commands to control
> > one or more PWMs attached to the Embedded Controller. Because the EC
> > allows us to modify the duty cycle (as a percentage, where U16_MAX is
> > 100%) but not the period, we assign the period a fixed value of
> > EC_PWM_MAX_DUTY and reject all attempts to change it.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> 
> > + */
> > +struct cros_ec_pwm_device {
> > +       struct device *dev;
> > +       struct cros_ec_device *ec;
> > +       struct pwm_chip chip;
> > +};
> > +
> > +static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
> > +{
> > +       return container_of(c, struct cros_ec_pwm_device, chip);
> > +}
> > +
> > +static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm,
> > +                                  struct pwm_device *pwm,
> > +                                  uint16_t duty)
> Given you seprated the pwm stuff from the EC stuff and focusing on
> sending a EC command here, the first parameter should be of
> cros_ec_device* instead of cros_ec_pwm_device*.

Good idea, done. I'll also change the 'pwm_device' arg into just a u8
index, since that's all we care about at this level of abstraction.

> > +{
> > +       struct cros_ec_device *ec = ec_pwm->ec;
> > +       struct ec_params_pwm_set_duty *params;
> > +       struct cros_ec_command *msg;
> > +       int ret;
> > +
> > +       msg = kzalloc(sizeof(*msg) + sizeof(*params), GFP_KERNEL);
> Use an ad-hoc data structure on the stack, so you will always be able
> to send the command to the EC.

Sure, can do. I guess an anonymous struct will do well here.

> > +       if (!msg)
> > +               return -ENOMEM;
> > +       params = (void *)&msg->data[0];
> > +
> > +       msg->version = 0;
> > +       msg->command = EC_CMD_PWM_SET_DUTY;
> > +       msg->insize = 0;
> > +       msg->outsize = sizeof(*params);
> > +
> > +       params->duty = duty;
> > +       params->pwm_type = EC_PWM_TYPE_GENERIC;
> > +       params->index = pwm->hwpwm;
> > +
> > +       ret = cros_ec_cmd_xfer_status(ec, msg);
> > +       kfree(msg);
> > +       return ret;
> > +}
> > +
> > +static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm,
> > +                               struct pwm_device *pwm)
> Idem.

Sure.

> > +{
> > +       struct cros_ec_device *ec = ec_pwm->ec;
> > +       struct ec_params_pwm_get_duty *params;
> > +       struct ec_response_pwm_get_duty *resp;
> > +       struct cros_ec_command *msg;
> > +       int ret;
> > +
> > +       msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
> Idem.

Will do. Here, I guess an anonymous struct containing a union of
ec_{params,response}_pwm_get_duty will do it.

> > +                       GFP_KERNEL);
> > +       if (!msg)
> > +               return -ENOMEM;
> > +       params = (void *)&msg->data[0];
> > +       resp = (void *)&msg->data[0];
> > +
> > +       msg->version = 0;
> > +       msg->command = EC_CMD_PWM_GET_DUTY;
> > +       msg->insize = sizeof(*params);
> > +       msg->outsize = sizeof(*resp);
> > +
> > +       params->pwm_type = EC_PWM_TYPE_GENERIC;
> > +       params->index = pwm->hwpwm;
> > +
> > +       ret = cros_ec_cmd_xfer_status(ec, msg);
> > +       if (ret < 0)
> > +               goto out;
> > +
> > +       ret = resp->duty;
> > +
> > +out:
> > +       kfree(msg);
> > +       return ret;
> > +}
> > +
> > +static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                            struct pwm_state *state)
> > +{
> > +       struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> > +
> > +       /* The EC won't let us change the period */
> > +       if (state->period != EC_PWM_MAX_DUTY)
> > +               return -EINVAL;
> > +
> > +       return cros_ec_pwm_set_duty(ec_pwm, pwm, state->duty_cycle);
> I would use ec_pwm->ec here.

Sure.

> > +}
> > +
> > +static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                                 struct pwm_state *state)
> > +{
> > +       struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> > +       int ret;
> > +
> > +       ret = cros_ec_pwm_get_duty(ec_pwm, pwm);
> > +       if (ret < 0) {
> > +               dev_err(chip->dev, "error getting initial duty: %d\n", ret);
> > +               return;
> > +       }
> > +
> > +       state->enabled = (ret > 0);
> > +       state->period = EC_PWM_MAX_DUTY;
> > +       state->duty_cycle = ret;
> > +}
> > +
> > +static struct pwm_device *
> > +cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> > +{
> > +       struct pwm_device *pwm;
> > +
> > +       if (args->args[0] >= pc->npwm)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> > +       if (IS_ERR(pwm))
> > +               return pwm;
> > +
> > +       /* The EC won't let us change the period */
> > +       pwm->args.period = EC_PWM_MAX_DUTY;
> > +
> > +       return pwm;
> > +}
> > +
> > +static const struct pwm_ops cros_ec_pwm_ops = {
> > +       .get_state      = cros_ec_pwm_get_state,
> > +       .apply          = cros_ec_pwm_apply,
> > +       .owner          = THIS_MODULE,
> > +};
> > +
> > +static int cros_ec_pwm_probe(struct platform_device *pdev)
> > +{
> > +       struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *np = dev->of_node;
> > +       struct cros_ec_pwm_device *ec_pwm;
> > +       struct pwm_chip *chip;
> > +       u32 val;
> > +       int ret;
> > +
> > +       if (!ec) {
> > +               dev_err(dev, "no parent EC device\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ec_pwm = devm_kzalloc(dev, sizeof(*ec_pwm), GFP_KERNEL);
> > +       if (!ec_pwm)
> > +               return -ENOMEM;
> > +       chip = &ec_pwm->chip;
> > +       ec_pwm->ec = ec;
> > +
> > +       /* PWM chip */
> > +       chip->dev = dev;
> > +       chip->ops = &cros_ec_pwm_ops;
> > +       chip->of_xlate = cros_ec_pwm_xlate;
> > +       chip->of_pwm_n_cells = 1;
> > +       chip->base = -1;
> > +       ret = of_property_read_u32(np, "google,max-pwms", &val);
> > +       if (ret) {
> > +               dev_err(dev, "Couldn't read max-pwms property: %d\n", ret);
> Does it mean this driver does not work when device tree is not used by
> the platform?
> The rest of the driver still compiles.

Correct. I think that's just how many OF-based drivers tend to work;
they might *compile* with !CONFIG_OF, but all the useful functions will
return errors, and the probe will fail quickly. Anyway, for this
particular case (max-pwms), I think we've figured out we can possibly
discover this dynamically, so I might drop this property.

The bigger problem here is that we're doing PWM device
instantiation/matching through the use of OF-based translation (see the
->of_xlate and ->of_pwm_n_cells above). So if you're thinking about
using this driver as-is on non-DT platforms, you aren't going to get
very far :) Apparently there is some provision for this (see struct
pwm_lookup / PWM_LOOKUP()), but I haven't really analyzed how we could
adapt this for a cros_ec, non-DT system.

Brian

> > +               return ret;
> > +       }
> > +       /* The index field is only 8 bits */
> > +       if (val > U8_MAX) {
> > +               dev_err(dev, "Can't support %u PWMs\n", val);
> > +               return -EINVAL;
> > +       }
> > +       chip->npwm = val;
> > +
> > +       ret = pwmchip_add(chip);
> > +       if (ret < 0) {
> > +               dev_err(dev, "cannot register PWM: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, ec_pwm);
> > +
> > +       return ret;
> > +}
> > +
> > +static int cros_ec_pwm_remove(struct platform_device *dev)
> > +{
> > +       struct cros_ec_pwm_device *ec_pwm = platform_get_drvdata(dev);
> > +       struct pwm_chip *chip = &ec_pwm->chip;
> > +
> > +       return pwmchip_remove(chip);
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cros_ec_pwm_of_match[] = {
> > +       { .compatible = "google,cros-ec-pwm" },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_pwm_of_match);
> > +#endif
> > +
> > +static struct platform_driver cros_ec_pwm_driver = {
> > +       .probe = cros_ec_pwm_probe,
> > +       .remove = cros_ec_pwm_remove,
> > +       .driver = {
> > +               .name = "cros-ec-pwm",
> > +               .of_match_table = of_match_ptr(cros_ec_pwm_of_match),
> > +       },
> > +};
> > +module_platform_driver(cros_ec_pwm_driver);
> > +
> > +MODULE_ALIAS("platform:cros-ec-pwm");
> > +MODULE_DESCRIPTION("ChromeOS EC PWM driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.8.0.rc3.226.g39d4020
> >
