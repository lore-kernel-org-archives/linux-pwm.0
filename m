Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E815CE@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E815CE@DQHE06.ent.ti.com>
Date: Sat, 20 Jul 2013 22:26:26 +0200
Message-ID: <CACRpkdYVCrz_30HsX_4C5aFR0c3K4OzTXSo7gx_W39Ukpg8cpw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: add LP3943 I2C GPIO expander driver
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: "Kim, Milo" <Milo.Kim@ti.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>

I forgot one thing:

On Tue, Jul 16, 2013 at 4:38 AM, Kim, Milo <Milo.Kim@ti.com> wrote:

> +static int lp3943_gpio_probe(struct platform_device *pdev)
> +{
> +       struct lp3943 *l = dev_get_drvdata(pdev->dev.parent);
> +       struct lp3943_gpio *lg;
> +       int ret;

This is where I want you to assign to a member of struct
lp3943 another u16 mask which tells which lines are
actually available for GPIO, and you should also add code to
make sure that lines that are not available fail gpio_request().

This configuration can probably be read out from the device
tree if you add the compatible node to the MFD cell when
registering it.

Yours,
Linus Walleij
