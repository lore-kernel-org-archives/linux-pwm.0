From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Date: Mon, 4 Mar 2019 13:36:34 +0100
Message-ID: <CAKKE0ZFs_N+StJ4MQ0peaTy=ADufSVW_tp5zSHsyua2myvMiHQ@mail.gmail.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com> <20190220164154.00547a77@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220164154.00547a77@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 20, 2019 at 5:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
[skipped]
> > +
> > +struct ftm_quaddec {
> > +     struct platform_device *pdev;
> > +     void __iomem *ftm_base;
> > +     bool big_endian;
>
> I'm curious. What is the benefit of running in big endian mode?

It is based on the same behaviour as in drivers/clocksource/timer-fsl-ftm.c
The FlexTimer itself on the board I'm testing it with is working in
big endian mode, so this mode is required.

> > +static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
> > +                             uintptr_t private,
> > +                             struct iio_chan_spec const *chan,
> > +                             const char *buf, size_t len)
> > +{
> > +     struct ftm_quaddec *ftm = iio_priv(indio_dev);
> > +
> > +     /* Only "counter reset" is supported for now */
> > +     if (!sysfs_streq(buf, "0")) {
> > +             dev_warn(&ftm->pdev->dev, "Reset only accepts '0'\n");
> > +             return -EINVAL;
>
> Why not just make the channel attribute itself writeable given we are
> setting it to 0?

Good idea, I'll see if this can be applied in the new subsystem.

[skipped]

All other comments are Acked.
