Return-Path: <tmaimon77@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180529165617.GD2162@roeck-us.net>
References: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
 <1527588141-18639-3-git-send-email-tmaimon77@gmail.com> <20180529165617.GD2162@roeck-us.net>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 30 May 2018 18:44:58 +0300
Message-ID: <CAP6Zq1h8_n8R=dqmBxC_bK_YstLt1kkE6UCp2OVsNpKp=RK8og@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: npcm-pwm: add NPCM7xx PWM driver
Content-Type: multipart/alternative; boundary="000000000000b2def7056d6e3bdf"
List-ID: <linux-pwm.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, jdelvare@suse.com, Avi Fishman <avifishman70@gmail.com>, Nancy Yuen <yuenn@google.com>, Brendan Higgins <brendanhiggins@google.com>, Patrick Venture <venture@google.com>, Joel Stanley <joel@jms.id.au>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

--000000000000b2def7056d6e3bdf
Content-Type: text/plain; charset="UTF-8"

Hi  Guenter,

Thanks for your prompt reply!


On 29 May 2018 at 19:56, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, May 29, 2018 at 01:02:21PM +0300, Tomer Maimon wrote:
> > Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.
> >
> > The Nuvoton BMC NPCM7xx has two identical PWM controller modules,
> > each module has four PWM controller outputs.
> >
>
> I don't see it guaranteed that all future NPCM7xx devices will be PWM
> controllers, much less that they will be compatible to the chip really
>

Actually all NPCM7xx family have PWM and FAN modules support,


> supported here. NPCM750, I presume ? I would suggest name the driver
> accordingly.
>

The compatible name can not be a family name like nuvoton,npcm7xx-pwm, only
a specific chip name. (in our case the NPCM750 is the full modules SOC)
still you think i should change the driver name? (note: all of our NPCM7xx
unique modules drivers are named npcm7xx-*.c or *-npcm7xx.c)


> As a generic pwm driver, not specifically tied to a fan controller,
> this driver does not belong into hwmon. It should be added to the pwm
> subsystem. Copying the maintainer and mailing list.
>
> In the NPCM7xx we have PWM and FAN controller modules,  usually in the
aspect of our BMC clients the two module
are used together to control the fans.

But because in the NPCM7xx the PWM and the FAN controller are separate
modules we
thought to do two separate drivers in the hwmon
is it possible? or you think it is better to do one hwmon driver for the
PWM and the FAN controller.

note that we were going to submit soon also the FAN controller driver under
hwmon.


> If the pwm chip is used to control fans, the existing pwm-fan driver can
> then be used to create the necessary mapping from pwm controls to fans.
>
> Guenter
>

Thanks,

Tomer

>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/hwmon/Kconfig       |   6 +
> >  drivers/hwmon/Makefile      |   1 +
> >  drivers/hwmon/npcm7xx-pwm.c | 363 ++++++++++++++++++++++++++++++
> ++++++++++++++
> >  3 files changed, 370 insertions(+)
> >  create mode 100644 drivers/hwmon/npcm7xx-pwm.c
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 6ec307c93ece..693ba09cff8e 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1891,6 +1891,12 @@ config SENSORS_XGENE
> >         If you say yes here you get support for the temperature
> >         and power sensors for APM X-Gene SoC.
> >
> > +config SENSORS_NPCM7XX
> > +     tristate "Nuvoton NPCM7XX PWM driver"
> > +     help
> > +       This driver provides support for Nuvoton NPCM7XX PWM
> > +       controller.
> > +
> >  if ACPI
> >
> >  comment "ACPI drivers"
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e7d52a36e6c4..24aad895a3bb 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -174,6 +174,7 @@ obj-$(CONFIG_SENSORS_W83L786NG)   += w83l786ng.o
> >  obj-$(CONFIG_SENSORS_WM831X) += wm831x-hwmon.o
> >  obj-$(CONFIG_SENSORS_WM8350) += wm8350-hwmon.o
> >  obj-$(CONFIG_SENSORS_XGENE)  += xgene-hwmon.o
> > +obj-$(CONFIG_SENSORS_NPCM7XX)        += npcm7xx-pwm.o
> >
> >  obj-$(CONFIG_PMBUS)          += pmbus/
> >
> > diff --git a/drivers/hwmon/npcm7xx-pwm.c b/drivers/hwmon/npcm7xx-pwm.c
> > new file mode 100644
> > index 000000000000..6122ca82b94d
> > --- /dev/null
> > +++ b/drivers/hwmon/npcm7xx-pwm.c
> > @@ -0,0 +1,363 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2014-2018 Nuvoton Technology corporation.
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> > +
> > +/* NPCM7XX PWM port base address */
> > +#define NPCM7XX_PWM_REG_PR           0x0
> > +#define NPCM7XX_PWM_REG_CSR          0x4
> > +#define NPCM7XX_PWM_REG_CR           0x8
> > +#define NPCM7XX_PWM_REG_CNRx(PORT)   (0xC + (12 * PORT))
> > +#define NPCM7XX_PWM_REG_CMRx(PORT)   (0x10 + (12 * PORT))
> > +#define NPCM7XX_PWM_REG_PDRx(PORT)   (0x14 + (12 * PORT))
> > +#define NPCM7XX_PWM_REG_PIER         0x3C
> > +#define NPCM7XX_PWM_REG_PIIR         0x40
> > +
> > +#define NPCM7XX_PWM_CTRL_CH0_MODE_BIT                BIT(3)
> > +#define NPCM7XX_PWM_CTRL_CH1_MODE_BIT                BIT(11)
> > +#define NPCM7XX_PWM_CTRL_CH2_MODE_BIT                BIT(15)
> > +#define NPCM7XX_PWM_CTRL_CH3_MODE_BIT                BIT(19)
> > +
> > +#define NPCM7XX_PWM_CTRL_CH0_INV_BIT         BIT(2)
> > +#define NPCM7XX_PWM_CTRL_CH1_INV_BIT         BIT(10)
> > +#define NPCM7XX_PWM_CTRL_CH2_INV_BIT         BIT(14)
> > +#define NPCM7XX_PWM_CTRL_CH3_INV_BIT         BIT(18)
> > +
> > +#define NPCM7XX_PWM_CTRL_CH0_EN_BIT          BIT(0)
> > +#define NPCM7XX_PWM_CTRL_CH1_EN_BIT          BIT(8)
> > +#define NPCM7XX_PWM_CTRL_CH2_EN_BIT          BIT(12)
> > +#define NPCM7XX_PWM_CTRL_CH3_EN_BIT          BIT(16)
> > +
> > +/* Define the maximum PWM channel number */
> > +#define NPCM7XX_PWM_MAX_CHN_NUM                      8
> > +#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE  4
> > +#define NPCM7XX_PWM_MAX_MODULES                 2
> > +
> > +/* Define the Counter Register, value = 100 for match 100% */
> > +#define NPCM7XX_PWM_COUNTER_DEFALUT_NUM              255
> > +#define NPCM7XX_PWM_COMPARATOR_DEFALUT_NUM   127
> > +
> > +#define NPCM7XX_PWM_COMPARATOR_MAX           255
> > +
> > +
> > +/* default all PWM channels PRESCALE2 = 1 */
> > +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH0    0x4
> > +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH1    0x40
> > +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH2    0x400
> > +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH3    0x4000
> > +
> > +#define PWM_OUTPUT_FREQ_25KHZ                        25000
> > +#define PWN_CNT_DEFAULT                              256
> > +#define MIN_PRESCALE1                                2
> > +#define NPCM7XX_PWM_PRESCALE_SHIFT_CH01              8
> > +
> > +#define NPCM7XX_PWM_PRESCALE2_DEFALUT        (NPCM7XX_PWM_PRESCALE2_DEFALUT_CH0
> | \
> > +                                     NPCM7XX_PWM_PRESCALE2_DEFALUT_CH1
> | \
> > +                                     NPCM7XX_PWM_PRESCALE2_DEFALUT_CH2
> | \
> > +                                     NPCM7XX_PWM_PRESCALE2_DEFALUT_CH3)
> > +
> > +#define NPCM7XX_PWM_CTRL_MODE_DEFALUT
> (NPCM7XX_PWM_CTRL_CH0_MODE_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH1_MODE_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH2_MODE_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH3_MODE_BIT)
> > +
> > +#define NPCM7XX_PWM_CTRL_EN_DEFALUT  (NPCM7XX_PWM_CTRL_CH0_EN_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH1_EN_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH2_EN_BIT | \
> > +                                     NPCM7XX_PWM_CTRL_CH3_EN_BIT)
> > +
> > +struct npcm7xx_pwm_data {
> > +     unsigned long clk_freq;
> > +     void __iomem *pwm_base[NPCM7XX_PWM_MAX_MODULES];
> > +     struct mutex npcm7xx_pwm_lock[NPCM7XX_PWM_MAX_CHN_NUM];
> > +};
> > +
> > +static const struct of_device_id pwm_dt_id[];
> > +
> > +static int npcm7xx_pwm_config_set(struct npcm7xx_pwm_data *data, int
> channel,
> > +                               u16 val)
> > +{
> > +     u32 PWMChannel = (channel % NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
> > +     u32 n_module = (channel / NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
> > +     u32 u32TmpBuf = 0, ctrl_en_bit;
> > +
> > +     /*
> > +      * Config PWM Comparator register for setting duty cycle
> > +      */
> > +     if (val < 0 || val > NPCM7XX_PWM_COMPARATOR_MAX)
> > +             return -EINVAL;
> > +
> > +     /* write new CMR value  */
> > +     iowrite32(val, data->pwm_base[n_module] +
> > +               NPCM7XX_PWM_REG_CMRx(PWMChannel));
> > +
> > +     u32TmpBuf = ioread32(data->pwm_base[n_module] +
> NPCM7XX_PWM_REG_CR);
> > +
> > +     switch (PWMChannel) {
> > +     case 0:
> > +             ctrl_en_bit = NPCM7XX_PWM_CTRL_CH0_EN_BIT;
> > +             break;
> > +     case 1:
> > +             ctrl_en_bit = NPCM7XX_PWM_CTRL_CH1_EN_BIT;
> > +             break;
> > +     case 2:
> > +             ctrl_en_bit = NPCM7XX_PWM_CTRL_CH2_EN_BIT;
> > +             break;
> > +     case 3:
> > +             ctrl_en_bit = NPCM7XX_PWM_CTRL_CH3_EN_BIT;
> > +             break;
> > +     default:
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (val == 0)
> > +             /* Disable PWM */
> > +             u32TmpBuf &= ~(ctrl_en_bit);
> > +     else
> > +             /* Enable PWM */
> > +             u32TmpBuf |= ctrl_en_bit;
> > +
> > +     mutex_lock(&data->npcm7xx_pwm_lock[n_module]);
> > +     iowrite32(u32TmpBuf, data->pwm_base[n_module] +
> NPCM7XX_PWM_REG_CR);
> > +     mutex_unlock(&data->npcm7xx_pwm_lock[n_module]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int npcm7xx_read_pwm(struct device *dev, u32 attr, int channel,
> > +                          long *val)
> > +{
> > +     struct npcm7xx_pwm_data *data = dev_get_drvdata(dev);
> > +     u32 PWMChannel = (channel % NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
> > +     u32 n_module = (channel / NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             *val = (long)ioread32(data->pwm_base[n_module] +
> > +                                   NPCM7XX_PWM_REG_CMRx(PWMChannel));
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int npcm7xx_write_pwm(struct device *dev, u32 attr, int channel,
> > +                           long val)
> > +{
> > +     struct npcm7xx_pwm_data *data = dev_get_drvdata(dev);
> > +     int err = 0;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             err = npcm7xx_pwm_config_set(data, channel, (u16)val);
> > +             break;
> > +     default:
> > +             err = -EOPNOTSUPP;
> > +             break;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static umode_t npcm7xx_pwm_is_visible(const void *_data, u32 attr, int
> channel)
> > +{
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             return 0644;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static int npcm7xx_read(struct device *dev, enum hwmon_sensor_types
> type,
> > +                      u32 attr, int channel, long *val)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             return npcm7xx_read_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int npcm7xx_write(struct device *dev, enum hwmon_sensor_types
> type,
> > +                       u32 attr, int channel, long val)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             return npcm7xx_write_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t npcm7xx_is_visible(const void *data,
> > +                                enum hwmon_sensor_types type,
> > +                                u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             return npcm7xx_pwm_is_visible(data, attr, channel);
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static const u32 npcm7xx_pwm_config[] = {
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     HWMON_PWM_INPUT,
> > +     0
> > +};
> > +
> > +static const struct hwmon_channel_info npcm7xx_pwm = {
> > +     .type = hwmon_pwm,
> > +     .config = npcm7xx_pwm_config,
> > +};
> > +
> > +static const struct hwmon_channel_info *npcm7xx_info[] = {
> > +     &npcm7xx_pwm,
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops npcm7xx_hwmon_ops = {
> > +     .is_visible = npcm7xx_is_visible,
> > +     .read = npcm7xx_read,
> > +     .write = npcm7xx_write,
> > +};
> > +
> > +static const struct hwmon_chip_info npcm7xx_chip_info = {
> > +     .ops = &npcm7xx_hwmon_ops,
> > +     .info = npcm7xx_info,
> > +};
> > +
> > +static int npcm7xx_pwm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct npcm7xx_pwm_data *data;
> > +     struct resource res[NPCM7XX_PWM_MAX_MODULES];
> > +     struct device *hwmon;
> > +     struct clk *clk;
> > +     int m, ch, res_cnt, ret;
> > +     u32 Prescale_val, output_freq;
> > +
> > +     data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     for (res_cnt = 0; res_cnt < NPCM7XX_PWM_MAX_MODULES  ; res_cnt++) {
> > +             ret = of_address_to_resource(dev->of_node, res_cnt,
> > +                                          &res[res_cnt]);
> > +             if (ret) {
> > +                     pr_err("PWM of_address_to_resource fail ret %d\n",
> > +                            ret);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             data->pwm_base[res_cnt] =
> > +                     devm_ioremap_resource(dev, &(res[res_cnt]));
> > +             pr_debug("pwm%d base is 0x%08X, res.start 0x%08X , size
> 0x%08X\n",
> > +                      res_cnt, (u32)data->pwm_base[res_cnt],
> > +                      res[res_cnt].start, resource_size(&(res[res_cnt]))
> );
> > +
> > +             if (!data->pwm_base[res_cnt]) {
> > +                     pr_err("pwm probe failed: can't read pwm base
> address for resource %d.\n",
> > +                            res_cnt);
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             mutex_init(&data->npcm7xx_pwm_lock[res_cnt]);
> > +     }
> > +
> > +     clk = devm_clk_get(dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return -ENODEV;
> > +
> > +     data->clk_freq = clk_get_rate(clk);
> > +
> > +     /* Adjust NPCM7xx PWMs output frequency to ~25Khz */
> > +     output_freq = data->clk_freq / PWN_CNT_DEFAULT;
> > +     Prescale_val = DIV_ROUND_CLOSEST(output_freq,
> PWM_OUTPUT_FREQ_25KHZ);
> > +
> > +     /* If Prescale_val = 0, then the prescale output clock is stopped
> */
> > +     if (Prescale_val < MIN_PRESCALE1)
> > +             Prescale_val = MIN_PRESCALE1;
> > +     /*
> > +      * Prescale_val need to decrement in one because in the PWM
> Prescale
> > +      * register the Prescale value increment by one
> > +      */
> > +     Prescale_val--;
> > +
> > +     /* Setting PWM Prescale Register value register to both modules */
> > +     Prescale_val |= (Prescale_val << NPCM7XX_PWM_PRESCALE_SHIFT_CH01);
> > +
> > +     for (m = 0; m < NPCM7XX_PWM_MAX_MODULES  ; m++) {
> > +             iowrite32(Prescale_val,
> > +                       data->pwm_base[m] + NPCM7XX_PWM_REG_PR);
> > +             iowrite32(NPCM7XX_PWM_PRESCALE2_DEFALUT,
> > +                       data->pwm_base[m] + NPCM7XX_PWM_REG_CSR);
> > +             iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT,
> > +                       data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
> > +
> > +             for (ch = 0; ch < NPCM7XX_PWM_MAX_CHN_NUM; ch++) {
> > +                     iowrite32(NPCM7XX_PWM_COUNTER_DEFALUT_NUM,
> > +                               data->pwm_base[m] +
> NPCM7XX_PWM_REG_CNRx(ch));
> > +                     iowrite32(NPCM7XX_PWM_COMPARATOR_DEFALUT_NUM,
> > +                               data->pwm_base[m] +
> NPCM7XX_PWM_REG_CMRx(ch));
> > +             }
> > +
> > +             iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT |
> > +                       NPCM7XX_PWM_CTRL_EN_DEFALUT,
> > +                       data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
> > +     }
> > +
> > +     hwmon = devm_hwmon_device_register_with_info(dev, "npcm7xx_pwm",
> data,
> > +                                                  &npcm7xx_chip_info,
> NULL);
> > +
> > +     if (IS_ERR(hwmon)) {
> > +             pr_err("PWM Driver failed - devm_hwmon_device_register_with_groups
> failed\n");
> > +             return PTR_ERR(hwmon);
> > +     }
> > +
> > +     pr_info("NPCM7XX PWM Driver probed, PWM output Freq %dHz\n",
> > +             output_freq / ((Prescale_val & 0xf) + 1));
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id of_pwm_match_table[] = {
> > +     { .compatible = "nuvoton,npcm750-pwm", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, of_pwm_match_table);
> > +
> > +static struct platform_driver npcm7xx_pwm_driver = {
> > +     .probe          = npcm7xx_pwm_probe,
> > +     .driver         = {
> > +             .name   = "npcm7xx_pwm",
> > +             .of_match_table = of_pwm_match_table,
> > +     },
> > +};
> > +
> > +module_platform_driver(npcm7xx_pwm_driver);
> > +
> > +MODULE_DESCRIPTION("Nuvoton NPCM7XX PWM Driver");
> > +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.14.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--000000000000b2def7056d6e3bdf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">Guenter,</span><div><span style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;float:none;display:inline"><=
br></span></div><div><span style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">Thanks for your prompt repl=
y!</span></div><div><br></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On 29 May 2018 at 19:56, Guenter Roeck <span dir=3D"ltr">&lt;<=
a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On =
Tue, May 29, 2018 at 01:02:21PM +0300, Tomer Maimon wrote:<br>
&gt; Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.<br>
&gt; <br>
&gt; The Nuvoton BMC NPCM7xx has two identical PWM controller modules,<br>
&gt; each module has four PWM controller outputs.<br>
&gt; <br>
<br>
</span>I don&#39;t see it guaranteed that all future NPCM7xx devices will b=
e PWM<br>
controllers, much less that they will be compatible to the chip really<br><=
/blockquote><div>=C2=A0</div><div>

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">A=
ctually all NPCM7xx family have PWM and FAN modules support,=C2=A0</div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
supported here. NPCM750, I presume ? I would suggest name the driver<br>
accordingly.<br></blockquote><div>=C2=A0</div><div>The compatible name can =
not be a family name like nuvoton,npcm7xx-pwm, only a specific chip name. (=
in our case the NPCM750 is the full modules SOC)<br></div><div>still you th=
ink i should change the driver name? (note: all of our NPCM7xx unique modul=
es drivers are named npcm7xx-*.c or *-npcm7xx.c)=C2=A0</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
As a generic pwm driver, not specifically tied to a fan controller,<br>
this driver does not belong into hwmon. It should be added to the pwm<br>
subsystem. Copying the maintainer and mailing list.<br>
<br></blockquote><div>In the NPCM7xx we have PWM and FAN controller modules=
,=C2=A0 usually in the aspect of our BMC clients the two module</div><div>a=
re used together to control the fans.</div><div><br></div><div>But because =
in the NPCM7xx the PWM and the FAN controller are=20

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">separate<span>=C2=A0</span></span>modules=C2=A0we=
 thought to do two separate drivers in the hwmon</div><div>is it possible? =
or you think it is better to do one hwmon driver for the PWM and the FAN co=
ntroller.</div><div><br></div><div><span style=3D"color:rgb(34,34,34);font-=
family:arial,sans-serif;font-size:small;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">note that we w=
ere going to submit soon also the FAN controller driver under hwmon.</span>=
<br></div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
If the pwm chip is used to control fans, the existing pwm-fan driver can<br=
>
then be used to create the necessary mapping from pwm controls to fans.<br>
<br>
Guenter<br></blockquote><div><br></div><div>Thanks,</div><div><br></div><di=
v>Tomer=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Signed-off-by: Tomer Maimon &lt;<a href=3D"mailto:tmaimon77@gmail.com"=
>tmaimon77@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/hwmon/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 =
+<br>
&gt;=C2=A0 drivers/hwmon/Makefile=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/hwmon/npcm7xx-pwm.c | 363 ++++++++++++++++++++++++++++++=
<wbr>++++++++++++++<br>
&gt;=C2=A0 3 files changed, 370 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/hwmon/npcm7xx-pwm.c<br>
&gt; <br>
&gt; diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig<br>
&gt; index 6ec307c93ece..693ba09cff8e 100644<br>
&gt; --- a/drivers/hwmon/Kconfig<br>
&gt; +++ b/drivers/hwmon/Kconfig<br>
&gt; @@ -1891,6 +1891,12 @@ config SENSORS_XGENE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes here you get support f=
or the temperature<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and power sensors for APM X-Gene SoC.=
<br>
&gt;=C2=A0 <br>
&gt; +config SENSORS_NPCM7XX<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Nuvoton NPCM7XX PWM driver&quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0This driver provides support for Nuvoton N=
PCM7XX PWM<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0controller.<br>
&gt; +<br>
&gt;=C2=A0 if ACPI<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 comment &quot;ACPI drivers&quot;<br>
&gt; diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile<br>
&gt; index e7d52a36e6c4..24aad895a3bb 100644<br>
&gt; --- a/drivers/hwmon/Makefile<br>
&gt; +++ b/drivers/hwmon/Makefile<br>
&gt; @@ -174,6 +174,7 @@ obj-$(CONFIG_SENSORS_<wbr>W83L786NG)=C2=A0 =C2=A0+=
=3D w83l786ng.o<br>
&gt;=C2=A0 obj-$(CONFIG_SENSORS_WM831X) +=3D wm831x-hwmon.o<br>
&gt;=C2=A0 obj-$(CONFIG_SENSORS_WM8350) +=3D wm8350-hwmon.o<br>
&gt;=C2=A0 obj-$(CONFIG_SENSORS_XGENE)=C2=A0 +=3D xgene-hwmon.o<br>
&gt; +obj-$(CONFIG_SENSORS_NPCM7XX)=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D npcm7xx=
-pwm.o<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 obj-$(CONFIG_PMBUS)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D pmbus=
/<br>
&gt;=C2=A0 <br>
&gt; diff --git a/drivers/hwmon/npcm7xx-pwm.c b/drivers/hwmon/npcm7xx-pwm.c=
<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..6122ca82b94d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/hwmon/npcm7xx-pwm.c<br>
&gt; @@ -0,0 +1,363 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0<br>
&gt; +// Copyright (c) 2014-2018 Nuvoton Technology corporation.<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/device.h&gt;<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/hwmon.h&gt;<br>
&gt; +#include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt; +#include &lt;linux/sysfs.h&gt;<br>
&gt; +#include &lt;linux/of_irq.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +<br>
&gt; +/* NPCM7XX PWM port base address */<br>
&gt; +#define NPCM7XX_PWM_REG_PR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
0<br>
&gt; +#define NPCM7XX_PWM_REG_CSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4<br>
&gt; +#define NPCM7XX_PWM_REG_CR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
8<br>
&gt; +#define NPCM7XX_PWM_REG_CNRx(PORT)=C2=A0 =C2=A0(0xC + (12 * PORT))<br=
>
&gt; +#define NPCM7XX_PWM_REG_CMRx(PORT)=C2=A0 =C2=A0(0x10 + (12 * PORT))<b=
r>
&gt; +#define NPCM7XX_PWM_REG_PDRx(PORT)=C2=A0 =C2=A0(0x14 + (12 * PORT))<b=
r>
&gt; +#define NPCM7XX_PWM_REG_PIER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3C<br=
>
&gt; +#define NPCM7XX_PWM_REG_PIIR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br=
>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH0_MODE_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(3)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH1_MODE_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(11)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH2_MODE_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(15)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH3_MODE_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT(19)<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH0_INV_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(2)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH1_INV_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(10)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH2_INV_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(14)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH3_INV_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(18)<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH0_EN_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(0)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH1_EN_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(8)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH2_EN_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(12)<br>
&gt; +#define NPCM7XX_PWM_CTRL_CH3_EN_BIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(16)<br>
&gt; +<br>
&gt; +/* Define the maximum PWM channel number */<br>
&gt; +#define NPCM7XX_PWM_MAX_CHN_NUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_<wbr>MODULE=C2=A0 4<br>
&gt; +#define NPCM7XX_PWM_MAX_MODULES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt; +<br>
&gt; +/* Define the Counter Register, value =3D 100 for match 100% */<br>
&gt; +#define NPCM7XX_PWM_COUNTER_DEFALUT_<wbr>NUM=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 255<br>
&gt; +#define NPCM7XX_PWM_COMPARATOR_<wbr>DEFALUT_NUM=C2=A0 =C2=A0127<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_COMPARATOR_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0255<br>
&gt; +<br>
&gt; +<br>
&gt; +/* default all PWM channels PRESCALE2 =3D 1 */<br>
&gt; +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_<wbr>CH0=C2=A0 =C2=A0 0x4<br>
&gt; +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_<wbr>CH1=C2=A0 =C2=A0 0x40<br>
&gt; +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_<wbr>CH2=C2=A0 =C2=A0 0x400<br>
&gt; +#define NPCM7XX_PWM_PRESCALE2_DEFALUT_<wbr>CH3=C2=A0 =C2=A0 0x4000<br=
>
&gt; +<br>
&gt; +#define PWM_OUTPUT_FREQ_25KHZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 25000<br>
&gt; +#define PWN_CNT_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 256<br>
&gt; +#define MIN_PRESCALE1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt; +#define NPCM7XX_PWM_PRESCALE_SHIFT_<wbr>CH01=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_PRESCALE2_DEFALUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (NPC=
M7XX_PWM_PRESCALE2_<wbr>DEFALUT_CH0 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
PRESCALE2_DEFALUT_<wbr>CH1 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
PRESCALE2_DEFALUT_<wbr>CH2 | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
PRESCALE2_DEFALUT_<wbr>CH3)<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_CTRL_MODE_DEFALUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 (NPC=
M7XX_PWM_CTRL_CH0_MODE_BIT | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH1_MODE_BIT | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH2_MODE_BIT | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH3_MODE_BIT)<br>
&gt; +<br>
&gt; +#define NPCM7XX_PWM_CTRL_EN_DEFALUT=C2=A0 (NPCM7XX_PWM_CTRL_CH0_EN_BI=
T | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH1_EN_BIT | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH2_EN_BIT | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_=
CTRL_CH3_EN_BIT)<br>
&gt; +<br>
&gt; +struct npcm7xx_pwm_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long clk_freq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *pwm_base[NPCM7XX_PWM_MAX_<wbr>MODUL=
ES];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mutex npcm7xx_pwm_lock[NPCM7XX_PWM_<wbr>MA=
X_CHN_NUM];<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct of_device_id pwm_dt_id[];<br>
&gt; +<br>
&gt; +static int npcm7xx_pwm_config_set(struct npcm7xx_pwm_data *data, int =
channel,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 PWMChannel =3D (channel % NPCM7XX_PWM_MAX_CHN=
_NUM_IN_A_<wbr>MODULE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 n_module =3D (channel / NPCM7XX_PWM_MAX_CHN_N=
UM_IN_A_<wbr>MODULE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 u32TmpBuf =3D 0, ctrl_en_bit;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Config PWM Comparator register for setting dut=
y cycle<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (val &lt; 0 || val &gt; NPCM7XX_PWM_COMPARATOR=
_MAX)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* write new CMR value=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iowrite32(val, data-&gt;pwm_base[n_module] +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_RE=
G_CMRx(<wbr>PWMChannel));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32TmpBuf =3D ioread32(data-&gt;pwm_base[n_<wbr>m=
odule] + NPCM7XX_PWM_REG_CR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (PWMChannel) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl_en_bit =3D NPCM7=
XX_PWM_CTRL_CH0_EN_BIT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl_en_bit =3D NPCM7=
XX_PWM_CTRL_CH1_EN_BIT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl_en_bit =3D NPCM7=
XX_PWM_CTRL_CH2_EN_BIT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl_en_bit =3D NPCM7=
XX_PWM_CTRL_CH3_EN_BIT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (val =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Disable PWM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32TmpBuf &amp;=3D ~(=
ctrl_en_bit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Enable PWM */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32TmpBuf |=3D ctrl_e=
n_bit;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;data-&gt;npcm7xx_pwm_<wbr>lock[n_=
module]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iowrite32(u32TmpBuf, data-&gt;pwm_base[n_module] =
+ NPCM7XX_PWM_REG_CR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;data-&gt;npcm7xx_<wbr>pwm_lock[=
n_module]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int npcm7xx_read_pwm(struct device *dev, u32 attr, int channel=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 long *val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct npcm7xx_pwm_data *data =3D dev_get_drvdata=
(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 PWMChannel =3D (channel % NPCM7XX_PWM_MAX_CHN=
_NUM_IN_A_<wbr>MODULE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 n_module =3D (channel / NPCM7XX_PWM_MAX_CHN_N=
UM_IN_A_<wbr>MODULE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(data))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(data);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (attr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm_input:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*val =3D (long)ioread=
32(data-&gt;pwm_base[<wbr>n_module] +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_PWM_REG_CMR=
x(<wbr>PWMChannel));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int npcm7xx_write_pwm(struct device *dev, u32 attr, int channe=
l,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0long val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct npcm7xx_pwm_data *data =3D dev_get_drvdata=
(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (attr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm_input:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D npcm7xx_pwm_c=
onfig_set(data, channel, (u16)val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EOPNOTSUPP;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static umode_t npcm7xx_pwm_is_visible(const void *_data, u32 attr, in=
t channel)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (attr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm_input:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0644;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int npcm7xx_read(struct device *dev, enum hwmon_sensor_types t=
ype,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u32 attr, int channel, long *val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return npcm7xx_read_p=
wm(dev, attr, channel, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int npcm7xx_write(struct device *dev, enum hwmon_sensor_types =
type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0u32 attr, int channel, long val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return npcm7xx_write_=
pwm(dev, attr, channel, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static umode_t npcm7xx_is_visible(const void *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum hwmon_sensor_types type,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 attr, int channel)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case hwmon_pwm:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return npcm7xx_pwm_is=
_visible(data, attr, channel);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const u32 npcm7xx_pwm_config[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HWMON_PWM_INPUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A00<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct hwmon_channel_info npcm7xx_pwm =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type =3D hwmon_pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.config =3D npcm7xx_pwm_config,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct hwmon_channel_info *npcm7xx_info[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&amp;npcm7xx_pwm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0NULL<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct hwmon_ops npcm7xx_hwmon_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.is_visible =3D npcm7xx_is_visible,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read =3D npcm7xx_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.write =3D npcm7xx_write,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct hwmon_chip_info npcm7xx_chip_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.ops =3D &amp;npcm7xx_hwmon_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.info =3D npcm7xx_info,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int npcm7xx_pwm_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct npcm7xx_pwm_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource res[NPCM7XX_PWM_MAX_MODULES];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *hwmon;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk *clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int m, ch, res_cnt, ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 Prescale_val, output_freq;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D devm_kzalloc(dev, sizeof(*data), GFP_KER=
NEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (res_cnt =3D 0; res_cnt &lt; NPCM7XX_PWM_MAX_=
MODULES=C2=A0 ; res_cnt++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_address_to=
_resource(dev-&gt;<wbr>of_node, res_cnt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;res[res_cnt]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pr_err(&quot;PWM of_address_to_resource fail ret %d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;pwm_base[res=
_cnt] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0devm_ioremap_resource(dev, &amp;(res[res_cnt]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug(&quot;pwm%d =
base is 0x%08X, res.start 0x%08X , size 0x%08X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 res_cnt, (u32)data-&gt;pwm_base[res_cnt],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 res[res_cnt].start, resource_size(&amp;(res[res_cnt]))<wbr>);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data-&gt;pwm_bas=
e[res_cnt]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pr_err(&quot;pwm probe failed: can&#39;t read pwm base address for r=
esource %d.\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res_cnt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&amp;data-=
&gt;npcm7xx_pwm_<wbr>lock[res_cnt]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk =3D devm_clk_get(dev, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(clk))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data-&gt;clk_freq =3D clk_get_rate(clk);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Adjust NPCM7xx PWMs output frequency to ~25Khz=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0output_freq =3D data-&gt;clk_freq / PWN_CNT_DEFAU=
LT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Prescale_val =3D DIV_ROUND_CLOSEST(output_freq, P=
WM_OUTPUT_FREQ_25KHZ);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* If Prescale_val =3D 0, then the prescale outpu=
t clock is stopped */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (Prescale_val &lt; MIN_PRESCALE1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Prescale_val =3D MIN_=
PRESCALE1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Prescale_val need to decrement in one because =
in the PWM Prescale<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * register the Prescale value increment by one<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Prescale_val--;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Setting PWM Prescale Register value register t=
o both modules */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Prescale_val |=3D (Prescale_val &lt;&lt; NPCM7XX_=
PWM_PRESCALE_SHIFT_<wbr>CH01);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (m =3D 0; m &lt; NPCM7XX_PWM_MAX_MODULES=C2=
=A0 ; m++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32(Prescale_va=
l,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PWM_REG_PR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32(NPCM7XX_PWM=
_<wbr>PRESCALE2_DEFALUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PWM_REG_CSR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32(NPCM7XX_PWM=
_CTRL_<wbr>MODE_DEFALUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PWM_REG_CR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (ch =3D 0; ch &lt=
; NPCM7XX_PWM_MAX_CHN_NUM; ch++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0iowrite32(NPCM7XX_PWM_COUNTER_<wbr>DEFALUT_NUM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PW=
M_REG_CNRx(ch));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0iowrite32(NPCM7XX_PWM_<wbr>COMPARATOR_DEFALUT_NUM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PW=
M_REG_CMRx(ch));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iowrite32(NPCM7XX_PWM=
_CTRL_<wbr>MODE_DEFALUT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NPCM7XX_PWM_CTRL_EN_DEFALUT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0data-&gt;pwm_base[m] + NPCM7XX_PWM_REG_CR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hwmon =3D devm_hwmon_device_register_<wbr>with_in=
fo(dev, &quot;npcm7xx_pwm&quot;, data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;npcm7xx_chip_info, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(hwmon)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;PWM Driv=
er failed - devm_hwmon_device_register_<wbr>with_groups failed\n&quot;);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(hwmon)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pr_info(&quot;NPCM7XX PWM Driver probed, PWM outp=
ut Freq %dHz\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_freq / ((Presc=
ale_val &amp; 0xf) + 1));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id of_pwm_match_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;nuvoton,npcm750-pwm&quot;=
, },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{},<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, of_pwm_match_table);<br>
&gt; +<br>
&gt; +static struct platform_driver npcm7xx_pwm_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D npcm=
7xx_pwm_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0=3D=
 &quot;npcm7xx_pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D o=
f_pwm_match_table,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_platform_driver(<wbr>npcm7xx_pwm_driver);<br>
&gt; +<br>
&gt; +MODULE_DESCRIPTION(&quot;Nuvoton NPCM7XX PWM Driver&quot;);<br>
&gt; +MODULE_AUTHOR(&quot;Tomer Maimon &lt;<a href=3D"mailto:tomer.maimon@n=
uvoton.com">tomer.maimon@nuvoton.com</a>&gt;&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; -- <br>
&gt; 2.14.1<br>
&gt; <br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-h=
wmon&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--000000000000b2def7056d6e3bdf--
