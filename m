From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Date: Fri, 15 Feb 2019 11:22:48 +0100
Message-ID: <20190215102248.i2mggrw74lgs2owq@pengutronix.de>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
 <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: fabrice.gasnier@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Feb 15, 2019 at 09:23:48AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 13.02.2019 12:50, Fabrice Gasnier wrote:
> > Add a device link between the PWM consumer and the PWM provider. This
> > enforces the PWM user to get suspended before the PWM provider. It
> > allows proper synchronization of suspend/resume sequences: the PWM user
> > is responsible for properly stopping PWM, before the provider gets
> > suspended: see [1]. Add the device link in:
> > - of_pwm_get()
> > - pwm_get()
> > - devm_ variants
> > as it requires a reference to the device for the PWM consumer.
> > 
> > [1] https://lkml.org/lkml/2019/2/5/770
> > 
> > Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v3:
> > - add struct device to of_get_pwm() arguments to handle device link from
> >   there.
> > ---
> >  drivers/pwm/core.c  | 14 +++++++++++---
> >  include/linux/pwm.h |  6 ++++--
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 1581f6a..8cb5d4bc 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >  
> >  /**
> >   * of_pwm_get() - request a PWM via the PWM framework
> > + * @dev: device for PWM consumer
> >   * @np: device node to get the PWM from
> >   * @con_id: consumer name
> >   *
> > @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
> >   * error code on failure.
> >   */
> > -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> > +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> > +			      const char *con_id)
> >  {
> >  	struct pwm_device *pwm = NULL;
> >  	struct of_phandle_args args;
> > @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> >  	if (IS_ERR(pwm))
> >  		goto put;
> >  
> > +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> > +		pr_debug("%s(): device link not added\n", __func__);
> > +
> 
> Just asking... will this mechanism also be working for PWMs requested via
> sysfs? At a first look it seems not.

No, but I would not expect a problem because AFAIU userspace is
suspended before kernel devices. However as userspace might not notice
the suspend it probably fails to stop the pwm and so will likely prevent
the suspend.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
