Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1391626901-31684-3-git-send-email-mporter@linaro.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
	<1391626901-31684-3-git-send-email-mporter@linaro.org>
Date: Fri, 21 Mar 2014 20:33:00 -0700
Message-ID: <CAKzfze-1zerdOcYqyZOuMUPVNsYDkhj7bCfuj8N6JLoGsM0eBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: pulse: add TI ECAP driver
From: Matt Ranostay <mranostay@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec51866bebd92fb04f529a831
List-ID: <linux-pwm.vger.kernel.org>
To: Matt Porter <mporter@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>, Linux IIO List <linux-iio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

--bcaec51866bebd92fb04f529a831
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 5, 2014 at 11:01 AM, Matt Porter <mporter@linaro.org> wrote:

> Adds support for capturing PWM signals using the TI ECAP peripheral.
> This driver supports triggered buffer capture of pulses on multiple
> ECAP instances. In addition, the driver supports configurable polarity
> of the signal to be captured.
>
> Signed-off-by: Matt Porter <mporter@linaro.org>
>

Tested-by: Matt Ranostay <mranostay@gmail.com>


> ---
>  drivers/iio/pulse/Kconfig  |  20 ++
>  drivers/iio/pulse/Makefile |   6 +
>  drivers/iio/pulse/tiecap.c | 491
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 drivers/iio/pulse/Kconfig
>  create mode 100644 drivers/iio/pulse/Makefile
>  create mode 100644 drivers/iio/pulse/tiecap.c
>
> diff --git a/drivers/iio/pulse/Kconfig b/drivers/iio/pulse/Kconfig
> new file mode 100644
> index 0000000..9864d4b
> --- /dev/null
> +++ b/drivers/iio/pulse/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Pulse Capture Devices
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Pulse Capture Devices"
> +
> +config IIO_TIECAP
> +       tristate "TI ECAP Pulse Capture"
> +       depends on SOC_AM33XX
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +        If you say yes here you get support for the TI ECAP peripheral
> +        in pulse capture mode.
> +
> +        This driver can also be built as a module.  If so, the module
> +        will be called tiecap
> +
> +endmenu
> diff --git a/drivers/iio/pulse/Makefile b/drivers/iio/pulse/Makefile
> new file mode 100644
> index 0000000..94d4b00
> --- /dev/null
> +++ b/drivers/iio/pulse/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for IIO PWM Capture Devices
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_IIO_TIECAP)       += tiecap.o
> diff --git a/drivers/iio/pulse/tiecap.c b/drivers/iio/pulse/tiecap.c
> new file mode 100644
> index 0000000..fd96745
> --- /dev/null
> +++ b/drivers/iio/pulse/tiecap.c
> @@ -0,0 +1,491 @@
> +/*
> + * ECAP IIO pulse capture driver
> + *
> + * Copyright (C) 2014 Linaro Limited
> + * Author: Matt Porter <mporter@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "../../pwm/pwm-tipwmss.h"
> +
> +/* ECAP regs and bits */
> +#define CAP1                   0x08
> +#define CAP2                   0x0c
> +#define ECCTL1                 0x28
> +#define ECCTL1_RUN_FREE                BIT(15)
> +#define ECCTL1_CAPLDEN         BIT(8)
> +#define ECCTL1_CAP2POL         BIT(2)
> +#define ECCTL1_CTRRST1         BIT(1)
> +#define ECCTL1_CAP1POL         BIT(0)
> +#define ECCTL2                 0x2a
> +#define ECCTL2_SYNCO_SEL_DIS   BIT(7)
> +#define ECCTL2_TSCTR_FREERUN   BIT(4)
> +#define ECCTL2_REARM           BIT(3)
> +#define ECCTL2_STOP_WRAP_2     BIT(1)
> +#define ECEINT                 0x2c
> +#define ECFLG                  0x2e
> +#define ECCLR                  0x30
> +#define ECINT_CTRCMP           BIT(7)
> +#define ECINT_CTRPRD           BIT(6)
> +#define ECINT_CTROVF           BIT(5)
> +#define ECINT_CEVT4            BIT(4)
> +#define ECINT_CEVT3            BIT(3)
> +#define ECINT_CEVT2            BIT(2)
> +#define ECINT_CEVT1            BIT(1)
> +#define ECINT_ALL              (ECINT_CTRCMP | \
> +                               ECINT_CTRPRD |  \
> +                               ECINT_CTROVF |  \
> +                               ECINT_CEVT4 |   \
> +                               ECINT_CEVT3 |   \
> +                               ECINT_CEVT2 |   \
> +                               ECINT_CEVT1)
> +
> +/* ECAP driver flags */
> +#define ECAP_POLARITY_HIGH     BIT(1)
> +#define ECAP_ENABLED           BIT(0)
> +
> +struct ecap_context {
> +       u32     cap1;
> +       u32     cap2;
> +       u16     ecctl1;
> +       u16     ecctl2;
> +       u16     eceint;
> +};
> +
> +struct ecap_state {
> +       unsigned long           flags;
> +       unsigned int            clk_rate;
> +       void __iomem            *regs;
> +       u32                     *buf;
> +       struct ecap_context     ctx;
> +};
> +
> +#define dev_to_ecap_state(d)   iio_priv(dev_to_iio_dev(d))
> +
> +static const struct iio_chan_spec ecap_channels[] = {
> +       {
> +               .type           = IIO_PULSE,
> +               .info_mask_separate =
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +               .scan_index     = 0,
> +               .scan_type = {
> +                       .sign           = 'u',
> +                       .realbits       = 32,
> +                       .storagebits    = 32,
> +                       .endianness     = IIO_LE,
> +               },
> +       },
> +       IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +static ssize_t ecap_attr_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +       return sprintf(buf, "%d\n",
> +                      test_bit(ECAP_POLARITY_HIGH, &state->flags));
> +}
> +
> +static ssize_t ecap_attr_store(struct device *dev,
> +                              struct device_attribute *attr,
> +                              const char *buf,
> +                              size_t len)
> +{
> +       int ret;
> +       bool val;
> +       struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +       if (test_bit(ECAP_ENABLED, &state->flags))
> +               return -EINVAL;
> +
> +       ret = strtobool(buf, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val)
> +               set_bit(ECAP_POLARITY_HIGH, &state->flags);
> +       else
> +               clear_bit(ECAP_POLARITY_HIGH, &state->flags);
> +
> +       return len;
> +}
> +
> +static IIO_DEVICE_ATTR(pulse_polarity, S_IRUGO | S_IWUSR,
> +       ecap_attr_show, ecap_attr_store, 0);
> +
> +static struct attribute *ecap_attributes[] = {
> +       &iio_dev_attr_pulse_polarity.dev_attr.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group ecap_attribute_group = {
> +       .attrs = ecap_attributes,
> +};
> +
> +static int ecap_read_raw(struct iio_dev *idev,
> +                       struct iio_chan_spec const *ch, int *val,
> +                       int *val2, long mask)
> +{
> +       struct ecap_state *state = iio_priv(idev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               /*
> +                * Always return 0 as a pulse width sample
> +                * is only valid in a triggered condition
> +                */
> +               *val = 0;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = 0;
> +               *val2 = NSEC_PER_SEC / state->clk_rate;
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info ecap_info = {
> +       .driver_module = THIS_MODULE,
> +       .attrs = &ecap_attribute_group,
> +       .read_raw = &ecap_read_raw,
> +};
> +
> +static irqreturn_t ecap_trigger_handler(int irq, void *private)
> +{
> +       struct iio_poll_func *pf = private;
> +       struct iio_dev *idev = pf->indio_dev;
> +       struct ecap_state *state = iio_priv(idev);
> +
> +       /* Read pulse counter value */
> +       *state->buf = readl(state->regs + CAP2);
> +
> +       iio_push_to_buffers_with_timestamp(idev, state->buf,
> iio_get_time_ns());
> +
> +       iio_trigger_notify_done(idev->trig);
> +
> +       return IRQ_HANDLED;
> +};
> +
> +
> +static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
> +       .owner = THIS_MODULE,
> +};
> +
> +static irqreturn_t ecap_interrupt_handler(int irq, void *private)
> +{
> +       struct iio_dev *idev = private;
> +       struct ecap_state *state = iio_priv(idev);
> +       u16 ints;
> +
> +       iio_trigger_poll(idev->trig, 0);
> +
> +       /* Clear CAP2 interrupt */
> +       ints = readw(state->regs + ECFLG);
> +       if (ints & ECINT_CEVT2)
> +               writew(ECINT_CEVT2, state->regs + ECCLR);
> +       else
> +               dev_warn(&idev->dev, "unhandled interrupt flagged: %04x\n",
> +                        ints);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ecap_buffer_predisable(struct iio_dev *idev)
> +{
> +       struct ecap_state *state = iio_priv(idev);
> +       int ret = 0;
> +       u16 ecctl2;
> +
> +       /* Stop capture */
> +       clear_bit(ECAP_ENABLED, &state->flags);
> +       ecctl2 = readw(state->regs + ECCTL2) & ~ECCTL2_TSCTR_FREERUN;
> +       writew(ecctl2, state->regs + ECCTL2);
> +
> +       /* Disable and clear all interrupts */
> +       writew(0, state->regs + ECEINT);
> +       writew(ECINT_ALL, state->regs + ECCLR);
> +
> +       ret = iio_triggered_buffer_predisable(idev);
> +
> +       pm_runtime_put_sync(idev->dev.parent);
> +
> +       return ret;
> +}
> +
> +static int ecap_buffer_postenable(struct iio_dev *idev)
> +{
> +       struct ecap_state *state = iio_priv(idev);
> +       int ret = 0;
> +       u16 ecctl1, ecctl2;
> +
> +       pm_runtime_get_sync(idev->dev.parent);
> +
> +       /* Configure pulse polarity */
> +       ecctl1 = readw(state->regs + ECCTL1);
> +       if (test_bit(ECAP_POLARITY_HIGH, &state->flags)) {
> +               /* CAP1 rising, CAP2 falling */
> +               ecctl1 |= ECCTL1_CAP2POL;
> +               ecctl1 &= ~ECCTL1_CAP1POL;
> +       } else {
> +               /* CAP1 falling, CAP2 rising */
> +               ecctl1 &= ~ECCTL1_CAP2POL;
> +               ecctl1 |= ECCTL1_CAP1POL;
> +       }
> +       writew(ecctl1, state->regs + ECCTL1);
> +
> +       /* Enable CAP2 interrupt */
> +       writew(ECINT_CEVT2, state->regs + ECEINT);
> +
> +       /* Enable capture */
> +       ecctl2 = readw(state->regs + ECCTL2);
> +       ecctl2 |= ECCTL2_TSCTR_FREERUN | ECCTL2_REARM;
> +       writew(ecctl2, state->regs + ECCTL2);
> +       set_bit(ECAP_ENABLED, &state->flags);
> +
> +       ret = iio_triggered_buffer_postenable(idev);
> +
> +       return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ecap_buffer_setup_ops = {
> +       .postenable = &ecap_buffer_postenable,
> +       .predisable = &ecap_buffer_predisable,
> +};
> +
> +static void ecap_init_hw(struct iio_dev *idev)
> +{
> +       struct ecap_state *state = iio_priv(idev);
> +
> +       clear_bit(ECAP_ENABLED, &state->flags);
> +       set_bit(ECAP_POLARITY_HIGH, &state->flags);
> +
> +       writew(ECCTL1_RUN_FREE | ECCTL1_CAPLDEN |
> +              ECCTL1_CAP2POL | ECCTL1_CTRRST1,
> +              state->regs + ECCTL1);
> +
> +       writew(ECCTL2_SYNCO_SEL_DIS | ECCTL2_STOP_WRAP_2,
> +              state->regs + ECCTL2);
> +}
> +
> +static const struct of_device_id ecap_of_ids[] = {
> +       { .compatible   = "ti,am33xx-ecap" },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ecap_of_ids);
> +
> +static int ecap_probe(struct platform_device *pdev)
> +{
> +       int irq, ret;
> +       struct iio_dev *idev;
> +       struct ecap_state *state;
> +       struct resource *r;
> +       struct clk *clk;
> +       struct iio_trigger *trig;
> +       u16 status;
> +
> +       idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct
> ecap_state));
> +       if (!idev)
> +               return -ENOMEM;
> +
> +       state = iio_priv(idev);
> +
> +       clk = devm_clk_get(&pdev->dev, "fck");
> +       if (IS_ERR(clk)) {
> +               dev_err(&pdev->dev, "failed to get clock\n");
> +               return PTR_ERR(clk);
> +       }
> +
> +       state->clk_rate = clk_get_rate(clk);
> +       if (!state->clk_rate) {
> +               dev_err(&pdev->dev, "failed to get clock rate\n");
> +               return -EINVAL;
> +       }
> +
> +       platform_set_drvdata(pdev, idev);
> +
> +       idev->dev.parent = &pdev->dev;
> +       idev->name = dev_name(&pdev->dev);
> +       idev->modes = INDIO_DIRECT_MODE;
> +       idev->info = &ecap_info;
> +       idev->channels = ecap_channels;
> +       /* One h/w capture and one s/w timestamp channel per instance */
> +       idev->num_channels = ARRAY_SIZE(ecap_channels);
> +
> +       trig = devm_iio_trigger_alloc(&pdev->dev, "%s-dev%d",
> +                                     idev->name, idev->id);
> +       if (!trig)
> +               return -ENOMEM;
> +       trig->dev.parent = idev->dev.parent;
> +       iio_trigger_set_drvdata(trig, idev);
> +       trig->ops = &iio_interrupt_trigger_ops;
> +
> +       ret = iio_trigger_register(trig);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to register trigger\n");
> +               return ret;
> +       }
> +
> +       ret = iio_triggered_buffer_setup(idev, NULL,
> +                                        &ecap_trigger_handler,
> +                                        &ecap_buffer_setup_ops);
> +       if (ret)
> +               return ret;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "no irq is specified\n");
> +               return irq;
> +       }
> +       ret = devm_request_irq(&pdev->dev, irq,
> +                               &ecap_interrupt_handler,
> +                               0, dev_name(&pdev->dev), idev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to request irq\n");
> +               goto uninit_buffer;
> +       }
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       state->regs = devm_ioremap_resource(&pdev->dev, r);
> +       if (IS_ERR(state->regs)) {
> +               dev_err(&pdev->dev, "unable to remap registers\n");
> +               ret = PTR_ERR(state->regs);
> +               goto uninit_buffer;
> +       };
> +
> +       ret = iio_device_register(idev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "unable to register device\n");
> +               goto uninit_buffer;
> +       }
> +
> +       state->buf = devm_kzalloc(&idev->dev, idev->scan_bytes,
> GFP_KERNEL);
> +       if (!state->buf) {
> +               ret = -ENOMEM;
> +               goto uninit_buffer;
> +       }
> +
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_get_sync(&pdev->dev);
> +
> +       status = pwmss_submodule_state_change(pdev->dev.parent,
> +                       PWMSS_ECAPCLK_EN);
> +       if (!(status & PWMSS_ECAPCLK_EN_ACK)) {
> +               dev_err(&pdev->dev, "failed to enable PWMSS config space
> clock\n");
> +               ret = -EINVAL;
> +               goto pwmss_clk_failure;
> +       }
> +
> +       ecap_init_hw(idev);
> +
> +       pm_runtime_put_sync(&pdev->dev);
> +
> +       return 0;
> +
> +pwmss_clk_failure:
> +       pm_runtime_put_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       iio_device_unregister(idev);
> +
> +uninit_buffer:
> +       iio_triggered_buffer_cleanup(idev);
> +
> +       return ret;
> +}
> +
> +static int ecap_remove(struct platform_device *pdev)
> +{
> +       struct iio_dev *idev = platform_get_drvdata(pdev);
> +
> +       pm_runtime_get_sync(&pdev->dev);
> +
> +       pwmss_submodule_state_change(pdev->dev.parent,
> PWMSS_ECAPCLK_STOP_REQ);
> +
> +       pm_runtime_put_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +
> +       iio_device_unregister(idev);
> +       iio_triggered_buffer_cleanup(idev);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ecap_suspend(struct device *dev)
> +{
> +       struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +       pm_runtime_get_sync(dev);
> +       state->ctx.cap1 = readl(state->regs + CAP1);
> +       state->ctx.cap2 = readl(state->regs + CAP2);
> +       state->ctx.eceint = readw(state->regs + ECEINT);
> +       state->ctx.ecctl1 = readw(state->regs + ECCTL1);
> +       state->ctx.ecctl2 = readw(state->regs + ECCTL2);
> +       pm_runtime_put_sync(dev);
> +
> +       /* If capture was active, disable ECAP */
> +       if (test_bit(ECAP_ENABLED, &state->flags))
> +               pm_runtime_put_sync(dev);
> +
> +       return 0;
> +}
> +
> +static int ecap_resume(struct device *dev)
> +{
> +       struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +       /* If capture was active, enable ECAP */
> +       if (test_bit(ECAP_ENABLED, &state->flags))
> +               pm_runtime_get_sync(dev);
> +
> +       pm_runtime_get_sync(dev);
> +       writel(state->ctx.cap1, state->regs + CAP1);
> +       writel(state->ctx.cap2, state->regs + CAP2);
> +       writew(state->ctx.eceint, state->regs + ECEINT);
> +       writew(state->ctx.ecctl1, state->regs + ECCTL1);
> +       writew(state->ctx.ecctl2, state->regs + ECCTL2);
> +       pm_runtime_put_sync(dev);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ecap_pm_ops, ecap_suspend, ecap_resume);
> +
> +static struct platform_driver ecap_iio_driver = {
> +       .driver = {
> +               .name           = "ecap",
> +               .owner          = THIS_MODULE,
> +               .of_match_table = of_match_ptr(ecap_of_ids),
> +               .pm             = &ecap_pm_ops,
> +       },
> +       .probe = ecap_probe,
> +       .remove = ecap_remove,
> +};
> +
> +module_platform_driver(ecap_iio_driver);
> +
> +MODULE_DESCRIPTION("ECAP IIO pulse capture driver");
> +MODULE_AUTHOR("Matt Porter <mporter@linaro.org>");
> +MODULE_LICENSE("GPL");
> --
> 1.8.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--bcaec51866bebd92fb04f529a831
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Wed, Feb 5, 2014 at 11:01 AM, Matt Porter <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mporter@linaro.org" target=3D"_blank">mporter@linaro.org</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Adds support for capturing PWM signals using=
 the TI ECAP peripheral.<br>
This driver supports triggered buffer capture of pulses on multiple<br>
ECAP instances. In addition, the driver supports configurable polarity<br>
of the signal to be captured.<br>
<br>
Signed-off-by: Matt Porter &lt;<a href=3D"mailto:mporter@linaro.org">mporte=
r@linaro.org</a>&gt;<br></blockquote><div><br></div><div>Tested-by: Matt Ra=
nostay &lt;<a href=3D"mailto:mranostay@gmail.com">mranostay@gmail.com</a>&g=
t;</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
---<br>
=A0drivers/iio/pulse/Kconfig =A0| =A020 ++<br>
=A0drivers/iio/pulse/Makefile | =A0 6 +<br>
=A0drivers/iio/pulse/tiecap.c | 491 +++++++++++++++++++++++++++++++++++++++=
++++++<br>
=A03 files changed, 517 insertions(+)<br>
=A0create mode 100644 drivers/iio/pulse/Kconfig<br>
=A0create mode 100644 drivers/iio/pulse/Makefile<br>
=A0create mode 100644 drivers/iio/pulse/tiecap.c<br>
<br>
diff --git a/drivers/iio/pulse/Kconfig b/drivers/iio/pulse/Kconfig<br>
new file mode 100644<br>
index 0000000..9864d4b<br>
--- /dev/null<br>
+++ b/drivers/iio/pulse/Kconfig<br>
@@ -0,0 +1,20 @@<br>
+#<br>
+# Pulse Capture Devices<br>
+#<br>
+# When adding new entries keep the list in alphabetical order<br>
+<br>
+menu &quot;Pulse Capture Devices&quot;<br>
+<br>
+config IIO_TIECAP<br>
+ =A0 =A0 =A0 tristate &quot;TI ECAP Pulse Capture&quot;<br>
+ =A0 =A0 =A0 depends on SOC_AM33XX<br>
+ =A0 =A0 =A0 select IIO_BUFFER<br>
+ =A0 =A0 =A0 select IIO_TRIGGERED_BUFFER<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0If you say yes here you get support for the TI ECAP periph=
eral<br>
+ =A0 =A0 =A0 =A0in pulse capture mode.<br>
+<br>
+ =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, the m=
odule<br>
+ =A0 =A0 =A0 =A0will be called tiecap<br>
+<br>
+endmenu<br>
diff --git a/drivers/iio/pulse/Makefile b/drivers/iio/pulse/Makefile<br>
new file mode 100644<br>
index 0000000..94d4b00<br>
--- /dev/null<br>
+++ b/drivers/iio/pulse/Makefile<br>
@@ -0,0 +1,6 @@<br>
+#<br>
+# Makefile for IIO PWM Capture Devices<br>
+#<br>
+<br>
+# When adding new entries keep the list in alphabetical order<br>
+obj-$(CONFIG_IIO_TIECAP) =A0 =A0 =A0 +=3D tiecap.o<br>
diff --git a/drivers/iio/pulse/tiecap.c b/drivers/iio/pulse/tiecap.c<br>
new file mode 100644<br>
index 0000000..fd96745<br>
--- /dev/null<br>
+++ b/drivers/iio/pulse/tiecap.c<br>
@@ -0,0 +1,491 @@<br>
+/*<br>
+ * ECAP IIO pulse capture driver<br>
+ *<br>
+ * Copyright (C) 2014 Linaro Limited<br>
+ * Author: Matt Porter &lt;<a href=3D"mailto:mporter@linaro.org">mporter@l=
inaro.org</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ */<br>
+<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/err.h&gt;<br>
+#include &lt;linux/iio/buffer.h&gt;<br>
+#include &lt;linux/iio/iio.h&gt;<br>
+#include &lt;linux/iio/sysfs.h&gt;<br>
+#include &lt;linux/iio/trigger.h&gt;<br>
+#include &lt;linux/iio/trigger_consumer.h&gt;<br>
+#include &lt;linux/iio/triggered_buffer.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/irq.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/of_device.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
+<br>
+#include &quot;../../pwm/pwm-tipwmss.h&quot;<br>
+<br>
+/* ECAP regs and bits */<br>
+#define CAP1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x08<br>
+#define CAP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0c<br>
+#define ECCTL1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x28<br>
+#define ECCTL1_RUN_FREE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(15)<br>
+#define ECCTL1_CAPLDEN =A0 =A0 =A0 =A0 BIT(8)<br>
+#define ECCTL1_CAP2POL =A0 =A0 =A0 =A0 BIT(2)<br>
+#define ECCTL1_CTRRST1 =A0 =A0 =A0 =A0 BIT(1)<br>
+#define ECCTL1_CAP1POL =A0 =A0 =A0 =A0 BIT(0)<br>
+#define ECCTL2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2a<br>
+#define ECCTL2_SYNCO_SEL_DIS =A0 BIT(7)<br>
+#define ECCTL2_TSCTR_FREERUN =A0 BIT(4)<br>
+#define ECCTL2_REARM =A0 =A0 =A0 =A0 =A0 BIT(3)<br>
+#define ECCTL2_STOP_WRAP_2 =A0 =A0 BIT(1)<br>
+#define ECEINT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2c<br>
+#define ECFLG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2e<br>
+#define ECCLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30<br>
+#define ECINT_CTRCMP =A0 =A0 =A0 =A0 =A0 BIT(7)<br>
+#define ECINT_CTRPRD =A0 =A0 =A0 =A0 =A0 BIT(6)<br>
+#define ECINT_CTROVF =A0 =A0 =A0 =A0 =A0 BIT(5)<br>
+#define ECINT_CEVT4 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)<br>
+#define ECINT_CEVT3 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)<br>
+#define ECINT_CEVT2 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)<br>
+#define ECINT_CEVT1 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)<br>
+#define ECINT_ALL =A0 =A0 =A0 =A0 =A0 =A0 =A0(ECINT_CTRCMP | \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CTRPRD =
| =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CTROVF =
| =A0\<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CEVT4 |=
 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CEVT3 |=
 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CEVT2 |=
 =A0 \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ECINT_CEVT1)<=
br>
+<br>
+/* ECAP driver flags */<br>
+#define ECAP_POLARITY_HIGH =A0 =A0 BIT(1)<br>
+#define ECAP_ENABLED =A0 =A0 =A0 =A0 =A0 BIT(0)<br>
+<br>
+struct ecap_context {<br>
+ =A0 =A0 =A0 u32 =A0 =A0 cap1;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 cap2;<br>
+ =A0 =A0 =A0 u16 =A0 =A0 ecctl1;<br>
+ =A0 =A0 =A0 u16 =A0 =A0 ecctl2;<br>
+ =A0 =A0 =A0 u16 =A0 =A0 eceint;<br>
+};<br>
+<br>
+struct ecap_state {<br>
+ =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;<br>
+ =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_rate;<br>
+ =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs;<br>
+ =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf;<br>
+ =A0 =A0 =A0 struct ecap_context =A0 =A0 ctx;<br>
+};<br>
+<br>
+#define dev_to_ecap_state(d) =A0 iio_priv(dev_to_iio_dev(d))<br>
+<br>
+static const struct iio_chan_spec ecap_channels[] =3D {<br>
+ =A0 =A0 =A0 {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D IIO_PULSE,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .info_mask_separate =3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(IIO_CHAN_INFO_RAW) | BIT(=
IIO_CHAN_INFO_SCALE),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .scan_index =A0 =A0 =3D 0,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .scan_type =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sign =A0 =A0 =A0 =A0 =A0 =3D=
 &#39;u&#39;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .realbits =A0 =A0 =A0 =3D 32,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .storagebits =A0 =A0=3D 32,<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .endianness =A0 =A0 =3D IIO_L=
E,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 IIO_CHAN_SOFT_TIMESTAMP(1)<br>
+};<br>
+<br>
+static ssize_t ecap_attr_show(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_att=
ribute *attr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D dev_to_ecap_state(dev);<br>
+<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0test_bit(ECAP_POLARITY_HIGH, &=
amp;state-&gt;flags));<br>
+}<br>
+<br>
+static ssize_t ecap_attr_store(struct device *dev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_=
attribute *attr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *bu=
f,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t len)<br=
>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 bool val;<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D dev_to_ecap_state(dev);<br>
+<br>
+ =A0 =A0 =A0 if (test_bit(ECAP_ENABLED, &amp;state-&gt;flags))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+<br>
+ =A0 =A0 =A0 ret =3D strtobool(buf, &amp;val);<br>
+ =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+<br>
+ =A0 =A0 =A0 if (val)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(ECAP_POLARITY_HIGH, &amp;state-&gt;fl=
ags);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(ECAP_POLARITY_HIGH, &amp;state-&gt;=
flags);<br>
+<br>
+ =A0 =A0 =A0 return len;<br>
+}<br>
+<br>
+static IIO_DEVICE_ATTR(pulse_polarity, S_IRUGO | S_IWUSR,<br>
+ =A0 =A0 =A0 ecap_attr_show, ecap_attr_store, 0);<br>
+<br>
+static struct attribute *ecap_attributes[] =3D {<br>
+ =A0 =A0 =A0 &amp;iio_dev_attr_pulse_polarity.dev_attr.attr,<br>
+ =A0 =A0 =A0 NULL,<br>
+};<br>
+<br>
+static struct attribute_group ecap_attribute_group =3D {<br>
+ =A0 =A0 =A0 .attrs =3D ecap_attributes,<br>
+};<br>
+<br>
+static int ecap_read_raw(struct iio_dev *idev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iio_chan_spec const *c=
h, int *val,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *val2, long mask)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+<br>
+ =A0 =A0 =A0 switch (mask) {<br>
+ =A0 =A0 =A0 case IIO_CHAN_INFO_RAW:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Always return 0 as a pulse width sample<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is only valid in a triggered condition<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT;<br>
+ =A0 =A0 =A0 case IIO_CHAN_INFO_SCALE:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val2 =3D NSEC_PER_SEC / state-&gt;clk_rate;<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT_PLUS_NANO;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+static const struct iio_info ecap_info =3D {<br>
+ =A0 =A0 =A0 .driver_module =3D THIS_MODULE,<br>
+ =A0 =A0 =A0 .attrs =3D &amp;ecap_attribute_group,<br>
+ =A0 =A0 =A0 .read_raw =3D &amp;ecap_read_raw,<br>
+};<br>
+<br>
+static irqreturn_t ecap_trigger_handler(int irq, void *private)<br>
+{<br>
+ =A0 =A0 =A0 struct iio_poll_func *pf =3D private;<br>
+ =A0 =A0 =A0 struct iio_dev *idev =3D pf-&gt;indio_dev;<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+<br>
+ =A0 =A0 =A0 /* Read pulse counter value */<br>
+ =A0 =A0 =A0 *state-&gt;buf =3D readl(state-&gt;regs + CAP2);<br>
+<br>
+ =A0 =A0 =A0 iio_push_to_buffers_with_timestamp(idev, state-&gt;buf, iio_g=
et_time_ns());<br>
+<br>
+ =A0 =A0 =A0 iio_trigger_notify_done(idev-&gt;trig);<br>
+<br>
+ =A0 =A0 =A0 return IRQ_HANDLED;<br>
+};<br>
+<br>
+<br>
+static const struct iio_trigger_ops iio_interrupt_trigger_ops =3D {<br>
+ =A0 =A0 =A0 .owner =3D THIS_MODULE,<br>
+};<br>
+<br>
+static irqreturn_t ecap_interrupt_handler(int irq, void *private)<br>
+{<br>
+ =A0 =A0 =A0 struct iio_dev *idev =3D private;<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+ =A0 =A0 =A0 u16 ints;<br>
+<br>
+ =A0 =A0 =A0 iio_trigger_poll(idev-&gt;trig, 0);<br>
+<br>
+ =A0 =A0 =A0 /* Clear CAP2 interrupt */<br>
+ =A0 =A0 =A0 ints =3D readw(state-&gt;regs + ECFLG);<br>
+ =A0 =A0 =A0 if (ints &amp; ECINT_CEVT2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(ECINT_CEVT2, state-&gt;regs + ECCLR);<=
br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&amp;idev-&gt;dev, &quot;unhandled i=
nterrupt flagged: %04x\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ints);<br>
+<br>
+ =A0 =A0 =A0 return IRQ_HANDLED;<br>
+}<br>
+<br>
+static int ecap_buffer_predisable(struct iio_dev *idev)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 u16 ecctl2;<br>
+<br>
+ =A0 =A0 =A0 /* Stop capture */<br>
+ =A0 =A0 =A0 clear_bit(ECAP_ENABLED, &amp;state-&gt;flags);<br>
+ =A0 =A0 =A0 ecctl2 =3D readw(state-&gt;regs + ECCTL2) &amp; ~ECCTL2_TSCTR=
_FREERUN;<br>
+ =A0 =A0 =A0 writew(ecctl2, state-&gt;regs + ECCTL2);<br>
+<br>
+ =A0 =A0 =A0 /* Disable and clear all interrupts */<br>
+ =A0 =A0 =A0 writew(0, state-&gt;regs + ECEINT);<br>
+ =A0 =A0 =A0 writew(ECINT_ALL, state-&gt;regs + ECCLR);<br>
+<br>
+ =A0 =A0 =A0 ret =3D iio_triggered_buffer_predisable(idev);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(idev-&gt;dev.parent);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int ecap_buffer_postenable(struct iio_dev *idev)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 u16 ecctl1, ecctl2;<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_get_sync(idev-&gt;dev.parent);<br>
+<br>
+ =A0 =A0 =A0 /* Configure pulse polarity */<br>
+ =A0 =A0 =A0 ecctl1 =3D readw(state-&gt;regs + ECCTL1);<br>
+ =A0 =A0 =A0 if (test_bit(ECAP_POLARITY_HIGH, &amp;state-&gt;flags)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CAP1 rising, CAP2 falling */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecctl1 |=3D ECCTL1_CAP2POL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecctl1 &amp;=3D ~ECCTL1_CAP1POL;<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CAP1 falling, CAP2 rising */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecctl1 &amp;=3D ~ECCTL1_CAP2POL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecctl1 |=3D ECCTL1_CAP1POL;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 writew(ecctl1, state-&gt;regs + ECCTL1);<br>
+<br>
+ =A0 =A0 =A0 /* Enable CAP2 interrupt */<br>
+ =A0 =A0 =A0 writew(ECINT_CEVT2, state-&gt;regs + ECEINT);<br>
+<br>
+ =A0 =A0 =A0 /* Enable capture */<br>
+ =A0 =A0 =A0 ecctl2 =3D readw(state-&gt;regs + ECCTL2);<br>
+ =A0 =A0 =A0 ecctl2 |=3D ECCTL2_TSCTR_FREERUN | ECCTL2_REARM;<br>
+ =A0 =A0 =A0 writew(ecctl2, state-&gt;regs + ECCTL2);<br>
+ =A0 =A0 =A0 set_bit(ECAP_ENABLED, &amp;state-&gt;flags);<br>
+<br>
+ =A0 =A0 =A0 ret =3D iio_triggered_buffer_postenable(idev);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static const struct iio_buffer_setup_ops ecap_buffer_setup_ops =3D {<br>
+ =A0 =A0 =A0 .postenable =3D &amp;ecap_buffer_postenable,<br>
+ =A0 =A0 =A0 .predisable =3D &amp;ecap_buffer_predisable,<br>
+};<br>
+<br>
+static void ecap_init_hw(struct iio_dev *idev)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D iio_priv(idev);<br>
+<br>
+ =A0 =A0 =A0 clear_bit(ECAP_ENABLED, &amp;state-&gt;flags);<br>
+ =A0 =A0 =A0 set_bit(ECAP_POLARITY_HIGH, &amp;state-&gt;flags);<br>
+<br>
+ =A0 =A0 =A0 writew(ECCTL1_RUN_FREE | ECCTL1_CAPLDEN |<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0ECCTL1_CAP2POL | ECCTL1_CTRRST1,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0state-&gt;regs + ECCTL1);<br>
+<br>
+ =A0 =A0 =A0 writew(ECCTL2_SYNCO_SEL_DIS | ECCTL2_STOP_WRAP_2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0state-&gt;regs + ECCTL2);<br>
+}<br>
+<br>
+static const struct of_device_id ecap_of_ids[] =3D {<br>
+ =A0 =A0 =A0 { .compatible =A0 =3D &quot;ti,am33xx-ecap&quot; },<br>
+ =A0 =A0 =A0 { /* sentinel */ },<br>
+};<br>
+MODULE_DEVICE_TABLE(of, ecap_of_ids);<br>
+<br>
+static int ecap_probe(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 int irq, ret;<br>
+ =A0 =A0 =A0 struct iio_dev *idev;<br>
+ =A0 =A0 =A0 struct ecap_state *state;<br>
+ =A0 =A0 =A0 struct resource *r;<br>
+ =A0 =A0 =A0 struct clk *clk;<br>
+ =A0 =A0 =A0 struct iio_trigger *trig;<br>
+ =A0 =A0 =A0 u16 status;<br>
+<br>
+ =A0 =A0 =A0 idev =3D devm_iio_device_alloc(&amp;pdev-&gt;dev, sizeof(stru=
ct ecap_state));<br>
+ =A0 =A0 =A0 if (!idev)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 state =3D iio_priv(idev);<br>
+<br>
+ =A0 =A0 =A0 clk =3D devm_clk_get(&amp;pdev-&gt;dev, &quot;fck&quot;);<br>
+ =A0 =A0 =A0 if (IS_ERR(clk)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to ge=
t clock\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(clk);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 state-&gt;clk_rate =3D clk_get_rate(clk);<br>
+ =A0 =A0 =A0 if (!state-&gt;clk_rate) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to ge=
t clock rate\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, idev);<br>
+<br>
+ =A0 =A0 =A0 idev-&gt;dev.parent =3D &amp;pdev-&gt;dev;<br>
+ =A0 =A0 =A0 idev-&gt;name =3D dev_name(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 idev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
+ =A0 =A0 =A0 idev-&gt;info =3D &amp;ecap_info;<br>
+ =A0 =A0 =A0 idev-&gt;channels =3D ecap_channels;<br>
+ =A0 =A0 =A0 /* One h/w capture and one s/w timestamp channel per instance=
 */<br>
+ =A0 =A0 =A0 idev-&gt;num_channels =3D ARRAY_SIZE(ecap_channels);<br>
+<br>
+ =A0 =A0 =A0 trig =3D devm_iio_trigger_alloc(&amp;pdev-&gt;dev, &quot;%s-d=
ev%d&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i=
dev-&gt;name, idev-&gt;id);<br>
+ =A0 =A0 =A0 if (!trig)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 trig-&gt;dev.parent =3D idev-&gt;dev.parent;<br>
+ =A0 =A0 =A0 iio_trigger_set_drvdata(trig, idev);<br>
+ =A0 =A0 =A0 trig-&gt;ops =3D &amp;iio_interrupt_trigger_ops;<br>
+<br>
+ =A0 =A0 =A0 ret =3D iio_trigger_register(trig);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to re=
gister trigger\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ret =3D iio_triggered_buffer_setup(idev, NULL,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&amp;ecap_trigger_handler,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&amp;ecap_buffer_setup_ops);<br>
+ =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+<br>
+ =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);<br>
+ =A0 =A0 =A0 if (irq &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;no irq is sp=
ecified\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 ret =3D devm_request_irq(&amp;pdev-&gt;dev, irq,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;ecap_int=
errupt_handler,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, dev_name(&=
amp;pdev-&gt;dev), idev);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;unable to re=
quest irq\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto uninit_buffer;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);<br>
+ =A0 =A0 =A0 state-&gt;regs =3D devm_ioremap_resource(&amp;pdev-&gt;dev, r=
);<br>
+ =A0 =A0 =A0 if (IS_ERR(state-&gt;regs)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;unable to re=
map registers\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(state-&gt;regs);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto uninit_buffer;<br>
+ =A0 =A0 =A0 };<br>
+<br>
+ =A0 =A0 =A0 ret =3D iio_device_register(idev);<br>
+ =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;unable to re=
gister device\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto uninit_buffer;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 state-&gt;buf =3D devm_kzalloc(&amp;idev-&gt;dev, idev-&gt;sc=
an_bytes, GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!state-&gt;buf) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto uninit_buffer;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_enable(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 pm_runtime_get_sync(&amp;pdev-&gt;dev);<br>
+<br>
+ =A0 =A0 =A0 status =3D pwmss_submodule_state_change(pdev-&gt;dev.parent,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PWMSS_ECAPCLK_EN);<br>
+ =A0 =A0 =A0 if (!(status &amp; PWMSS_ECAPCLK_EN_ACK)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;failed to en=
able PWMSS config space clock\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto pwmss_clk_failure;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 ecap_init_hw(idev);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(&amp;pdev-&gt;dev);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+<br>
+pwmss_clk_failure:<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 pm_runtime_disable(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 iio_device_unregister(idev);<br>
+<br>
+uninit_buffer:<br>
+ =A0 =A0 =A0 iio_triggered_buffer_cleanup(idev);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int ecap_remove(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 struct iio_dev *idev =3D platform_get_drvdata(pdev);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_get_sync(&amp;pdev-&gt;dev);<br>
+<br>
+ =A0 =A0 =A0 pwmss_submodule_state_change(pdev-&gt;dev.parent, PWMSS_ECAPC=
LK_STOP_REQ);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(&amp;pdev-&gt;dev);<br>
+ =A0 =A0 =A0 pm_runtime_disable(&amp;pdev-&gt;dev);<br>
+<br>
+ =A0 =A0 =A0 iio_device_unregister(idev);<br>
+ =A0 =A0 =A0 iio_triggered_buffer_cleanup(idev);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+#ifdef CONFIG_PM_SLEEP<br>
+static int ecap_suspend(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D dev_to_ecap_state(dev);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_get_sync(dev);<br>
+ =A0 =A0 =A0 state-&gt;ctx.cap1 =3D readl(state-&gt;regs + CAP1);<br>
+ =A0 =A0 =A0 state-&gt;ctx.cap2 =3D readl(state-&gt;regs + CAP2);<br>
+ =A0 =A0 =A0 state-&gt;ctx.eceint =3D readw(state-&gt;regs + ECEINT);<br>
+ =A0 =A0 =A0 state-&gt;ctx.ecctl1 =3D readw(state-&gt;regs + ECCTL1);<br>
+ =A0 =A0 =A0 state-&gt;ctx.ecctl2 =3D readw(state-&gt;regs + ECCTL2);<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(dev);<br>
+<br>
+ =A0 =A0 =A0 /* If capture was active, disable ECAP */<br>
+ =A0 =A0 =A0 if (test_bit(ECAP_ENABLED, &amp;state-&gt;flags))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(dev);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int ecap_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct ecap_state *state =3D dev_to_ecap_state(dev);<br>
+<br>
+ =A0 =A0 =A0 /* If capture was active, enable ECAP */<br>
+ =A0 =A0 =A0 if (test_bit(ECAP_ENABLED, &amp;state-&gt;flags))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(dev);<br>
+<br>
+ =A0 =A0 =A0 pm_runtime_get_sync(dev);<br>
+ =A0 =A0 =A0 writel(state-&gt;ctx.cap1, state-&gt;regs + CAP1);<br>
+ =A0 =A0 =A0 writel(state-&gt;ctx.cap2, state-&gt;regs + CAP2);<br>
+ =A0 =A0 =A0 writew(state-&gt;ctx.eceint, state-&gt;regs + ECEINT);<br>
+ =A0 =A0 =A0 writew(state-&gt;ctx.ecctl1, state-&gt;regs + ECCTL1);<br>
+ =A0 =A0 =A0 writew(state-&gt;ctx.ecctl2, state-&gt;regs + ECCTL2);<br>
+ =A0 =A0 =A0 pm_runtime_put_sync(dev);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+#endif<br>
+<br>
+static SIMPLE_DEV_PM_OPS(ecap_pm_ops, ecap_suspend, ecap_resume);<br>
+<br>
+static struct platform_driver ecap_iio_driver =3D {<br>
+ =A0 =A0 =A0 .driver =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;ecap&quot=
;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(ecap_of_ids)=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &amp;ecap_pm_=
ops,<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 .probe =3D ecap_probe,<br>
+ =A0 =A0 =A0 .remove =3D ecap_remove,<br>
+};<br>
+<br>
+module_platform_driver(ecap_iio_driver);<br>
+<br>
+MODULE_DESCRIPTION(&quot;ECAP IIO pulse capture driver&quot;);<br>
+MODULE_AUTHOR(&quot;Matt Porter &lt;<a href=3D"mailto:mporter@linaro.org">=
mporter@linaro.org</a>&gt;&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.4<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br></div></div>

--bcaec51866bebd92fb04f529a831--
