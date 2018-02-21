From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
Date: Wed, 21 Feb 2018 06:46:23 -0800
Message-ID: <c1192f75-0e6e-c735-67e1-2901624831ae@roeck-us.net>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mikko Perttunen <cyndis@kapsi.fi>, Rajkumar Rampelli <rrajk@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, gregory.clement@free-electrons.com, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, ldewangan@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 02/20/2018 11:15 PM, Mikko Perttunen wrote:
> AIUI, the PWM framework already exposes a sysfs node with period informat=
ion. We should just use that instead of adding a new driver for this.
> =


I am kind of lost. Please explain.

Are you saying that we should drop the pwm-fan driver as well (which goes
the opposite way), as well as any other drivers doing anything with pwm sig=
nals,
because after all those signals are already exposed to userspace a sysfs at=
tributes,
and a kernel driver to abstract those values is thus not needed ?

> In any case, we cannot add something like this to device tree since it's =
not a hardware device.
> =


So you are saying there is no means to express in devicetree that
a pwm input is connected to a fan ? How is that not hardware ?

If so, how do you express in devicetree that a pwm signal is connected
to anything ?

Guenter

> Mikko
> =

> On 21.02.2018 08:58, Rajkumar Rampelli wrote:
>> Add generic PWM based tachometer driver via HWMON interface
>> to report the RPM of motor. This drivers get the period/duty
>> cycle from PWM IP which captures the motor PWM output.
>>
>> This driver implements a simple interface for monitoring the speed of
>> a fan and exposes it in roatations per minute (RPM) to the user space
>> by using the hwmon's sysfs interface
>>
>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>> ---
>> =A0Documentation/hwmon/generic-pwm-tachometer |=A0 17 +++++
>> =A0drivers/hwmon/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 10 +++
>> =A0drivers/hwmon/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 1 +
>> =A0drivers/hwmon/generic-pwm-tachometer.c=A0=A0=A0=A0 | 112 ++++++++++++=
+++++++++++++++++
>> =A04 files changed, 140 insertions(+)
>> =A0create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>> =A0create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>
>> diff --git a/Documentation/hwmon/generic-pwm-tachometer b/Documentation/=
hwmon/generic-pwm-tachometer
>> new file mode 100644
>> index 0000000..e0713ee
>> --- /dev/null
>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>> @@ -0,0 +1,17 @@
>> +Kernel driver generic-pwm-tachometer
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This driver enables the use of a PWM module to monitor a fan. It uses t=
he
>> +generic PWM interface and can be used on SoCs as along as the SoC suppo=
rts
>> +Tachometer controller that moniors the Fan speed in periods.
>> +
>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>> +
>> +Description
>> +-----------
>> +
>> +The driver implements a simple interface for monitoring the Fan speed u=
sing
>> +PWM module and Tachometer controller. It requests period value through =
PWM
>> +capture interface to Tachometer and measures the Rotations per minute u=
sing
>> +received period value. It exposes the Fan speed in RPM to the user spac=
e by
>> +using the hwmon's sysfs interface.
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index ef23553..8912dcb 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>> =A0=A0=A0=A0=A0=A0 If you say yes here you get support for the temperatu=
re
>> =A0=A0=A0=A0=A0=A0 and power sensors for APM X-Gene SoC.
>>
>> +config GENERIC_PWM_TACHOMETER
>> +=A0=A0=A0 tristate "Generic PWM based tachometer driver"
>> +=A0=A0=A0 depends on PWM
>> +=A0=A0=A0 help
>> +=A0=A0=A0=A0=A0 Enables a driver to use PWM signal from motor to use
>> +=A0=A0=A0=A0=A0 for measuring the motor speed. The RPM is captured by
>> +=A0=A0=A0=A0=A0 PWM modules which has PWM capture capability and this
>> +=A0=A0=A0=A0=A0 drivers reads the captured data from PWM IP to convert
>> +=A0=A0=A0=A0=A0 it to speed in RPM.
>> +
>> =A0if ACPI
>>
>> =A0comment "ACPI drivers"
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index f814b4a..9dcc374 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)=A0=A0=A0 +=3D wm8350-hw=
mon.o
>> =A0obj-$(CONFIG_SENSORS_XGENE)=A0=A0=A0 +=3D xgene-hwmon.o
>>
>> =A0obj-$(CONFIG_PMBUS)=A0=A0=A0=A0=A0=A0=A0 +=3D pmbus/
>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) +=3D generic-pwm-tachometer.o
>>
>> =A0ccflags-$(CONFIG_HWMON_DEBUG_CHIP) :=3D -DDEBUG
>>
>> diff --git a/drivers/hwmon/generic-pwm-tachometer.c b/drivers/hwmon/gene=
ric-pwm-tachometer.c
>> new file mode 100644
>> index 0000000..9354d43
>> --- /dev/null
>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.=A0 All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHO=
UT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.=A0 See the GNU General Public Lice=
nse for
>> + * more details.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/err.h>
>> +#include <linux/pwm.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +
>> +struct pwm_hwmon_tach {
>> +=A0=A0=A0 struct device=A0=A0=A0=A0=A0=A0=A0 *dev;
>> +=A0=A0=A0 struct pwm_device=A0=A0=A0 *pwm;
>> +=A0=A0=A0 struct device=A0=A0=A0=A0=A0=A0=A0 *hwmon;
>> +};
>> +
>> +static ssize_t show_rpm(struct device *dev, struct device_attribute *at=
tr,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 char *buf)
>> +{
>> +=A0=A0=A0 struct pwm_hwmon_tach *ptt =3D dev_get_drvdata(dev);
>> +=A0=A0=A0 struct pwm_device *pwm =3D ptt->pwm;
>> +=A0=A0=A0 struct pwm_capture result;
>> +=A0=A0=A0 int err;
>> +=A0=A0=A0 unsigned int rpm =3D 0;
>> +
>> +=A0=A0=A0 err =3D pwm_capture(pwm, &result, 0);
>> +=A0=A0=A0 if (err < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0 dev_err(ptt->dev, "Failed to capture PWM: %d\n", =
err);
>> +=A0=A0=A0=A0=A0=A0=A0 return err;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 if (result.period)
>> +=A0=A0=A0=A0=A0=A0=A0 rpm =3D DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SE=
C,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
esult.period);
>> +
>> +=A0=A0=A0 return sprintf(buf, "%u\n", rpm);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>> +
>> +static struct attribute *pwm_tach_attrs[] =3D {
>> +=A0=A0=A0 &sensor_dev_attr_rpm.dev_attr.attr,
>> +=A0=A0=A0 NULL,
>> +};
>> +
>> +ATTRIBUTE_GROUPS(pwm_tach);
>> +
>> +static int pwm_tach_probe(struct platform_device *pdev)
>> +{
>> +=A0=A0=A0 struct pwm_hwmon_tach *ptt;
>> +=A0=A0=A0 int err;
>> +
>> +=A0=A0=A0 ptt =3D devm_kzalloc(&pdev->dev, sizeof(*ptt), GFP_KERNEL);
>> +=A0=A0=A0 if (!ptt)
>> +=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> +
>> +=A0=A0=A0 ptt->dev =3D &pdev->dev;
>> +
>> +=A0=A0=A0 platform_set_drvdata(pdev, ptt);
>> +=A0=A0=A0 dev_set_drvdata(&pdev->dev, ptt);
>> +
>> +=A0=A0=A0 ptt->pwm =3D devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, N=
ULL);
>> +=A0=A0=A0 if (IS_ERR(ptt->pwm)) {
>> +=A0=A0=A0=A0=A0=A0=A0 err =3D PTR_ERR(ptt->pwm);
>> +=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "Failed to get pwm handle, er=
r: %d\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err);
>> +=A0=A0=A0=A0=A0=A0=A0 return err;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 ptt->hwmon =3D devm_hwmon_device_register_with_groups(&pdev->=
dev,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "pwm_tach"=
, ptt, pwm_tach_groups);
>> +=A0=A0=A0 if (IS_ERR(ptt->hwmon)) {
>> +=A0=A0=A0=A0=A0=A0=A0 err =3D PTR_ERR_OR_ZERO(ptt->hwmon);
>> +=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "Failed to register hwmon dev=
ice: %d\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err);
>> +=A0=A0=A0=A0=A0=A0=A0 return err;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 return 0;
>> +}
>> +
>> +static const struct of_device_id pwm_tach_of_match[] =3D {
>> +=A0=A0=A0 { .compatible =3D "generic-pwm-tachometer" },
>> +=A0=A0=A0 {}
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_tach_of_match);
>> +
>> +static struct platform_driver pwm_tach_driver =3D {
>> +=A0=A0=A0 .driver =3D {
>> +=A0=A0=A0=A0=A0=A0=A0 .name =3D "generic-pwm-tachometer",
>> +=A0=A0=A0=A0=A0=A0=A0 .of_match_table =3D pwm_tach_of_match,
>> +=A0=A0=A0 },
>> +=A0=A0=A0 .probe =3D pwm_tach_probe,
>> +};
>> +
>> +module_platform_driver(pwm_tach_driver);
>> +
>> +MODULE_DESCRIPTION("PWM based Generic Tachometer driver");
>> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
>> +MODULE_AUTHOR("Rajkumar Rampelli <rrajk@nvidia.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> =
