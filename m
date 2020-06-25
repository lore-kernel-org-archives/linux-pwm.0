From: "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Date: Thu, 25 Jun 2020 12:23:54 +0800
Message-ID: <25560ece-5d71-562d-359a-490d70cc5453@linux.intel.com>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
 <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27978 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgFYEYA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 25 Jun 2020 00:24:00 -0400
In-Reply-To: <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com


Hi Philipp,

On 18/6/2020 8:25 pm, Philipp Zabel wrote:
> Hi Rahul,
>
> On Thu, 2020-06-18 at 20:05 +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/pwm/Kconfig         |   9 +
>>  drivers/pwm/Makefile        |   1 +
>>  drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 410 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>
> [...]
>> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
>> new file mode 100644
>> index 000000000000..3c7077acb161
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-intel-lgm.c
>> @@ -0,0 +1,400 @@
> [...]
>> +static int lgm_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct lgm_pwm_chip *pc;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *io_base;
>> +	int ret;
>> +
>> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>> +	if (!pc)
>> +		return -ENOMEM;
>> +
>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap)) {
>> +		ret = PTR_ERR(pc->regmap);
>> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
>> +		return ret;
>> +	}
>> +
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk)) {
>> +		ret = PTR_ERR(pc->clk);
>> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
>> +		return ret;
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(pc->rst)) {
>> +		ret = PTR_ERR(pc->rst);
>> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
>> +		return ret;
>> +	}
> Please use devm_reset_control_get_exclusive() to make it explicit an
> that exclusive reset control is requested. Given how the reset control
> is used, I think this driver could also use
> devm_reset_control_get_shared() to potentially allow sharing a reset
> line with other devices.

devm_reset_control_get() is a wrapper for devm_reset_control_get_exclusive().
Code as below:
static inline struct reset_control *devm_reset_control_get(
                                struct device *dev, const char *id)
{
        return devm_reset_control_get_exclusive(dev, id);
}
Am i missing something else?

Regards,
Rahul
