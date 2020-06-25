From: "Tanwar, Rahul" <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Date: Thu, 25 Jun 2020 16:59:51 +0800
Message-ID: <9a8f4a3e-c94a-b5bf-2715-03b0439f9fe7@linux.intel.com>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
 <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
 <25560ece-5d71-562d-359a-490d70cc5453@linux.intel.com>
 <20200625055818.nv5snblkm4nwvxw2@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200625055818.nv5snblkm4nwvxw2-T6qyLwKrzP+Pq0V0m3QNwQq/OYV65a7L4Y2cMoPwMik@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rahul.tanwar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 25/6/2020 1:58 pm, Uwe Kleine-König wrote:
> On Thu, Jun 25, 2020 at 12:23:54PM +0800, Tanwar, Rahul wrote:
>> Hi Philipp,
>>
>> On 18/6/2020 8:25 pm, Philipp Zabel wrote:
>>> Hi Rahul,
>>>
>>> On Thu, 2020-06-18 at 20:05 +0800, Rahul Tanwar wrote:
>>>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>>>> This PWM controller does not have any other consumer, it is a
>>>> dedicated PWM controller for fan attached to the system. Add
>>>> driver for this PWM fan controller.
>>>>
>>>> Signed-off-by: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>> ---
>>>>  drivers/pwm/Kconfig         |   9 +
>>>>  drivers/pwm/Makefile        |   1 +
>>>>  drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 410 insertions(+)
>>>>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>>>>
>>> [...]
>>>> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
>>>> new file mode 100644
>>>> index 000000000000..3c7077acb161
>>>> --- /dev/null
>>>> +++ b/drivers/pwm/pwm-intel-lgm.c
>>>> @@ -0,0 +1,400 @@
>>> [...]
>>>> +static int lgm_pwm_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct lgm_pwm_chip *pc;
>>>> +	struct device *dev = &pdev->dev;
>>>> +	void __iomem *io_base;
>>>> +	int ret;
>>>> +
>>>> +	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>>>> +	if (!pc)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	io_base = devm_platform_ioremap_resource(pdev, 0);
>>>> +	if (IS_ERR(io_base))
>>>> +		return PTR_ERR(io_base);
>>>> +
>>>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
>>>> +	if (IS_ERR(pc->regmap)) {
>>>> +		ret = PTR_ERR(pc->regmap);
>>>> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	pc->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(pc->clk)) {
>>>> +		ret = PTR_ERR(pc->clk);
>>>> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	pc->rst = devm_reset_control_get(dev, NULL);
>>>> +	if (IS_ERR(pc->rst)) {
>>>> +		ret = PTR_ERR(pc->rst);
>>>> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
>>>> +		return ret;
>>>> +	}
>>> Please use devm_reset_control_get_exclusive() to make it explicit an
>>> that exclusive reset control is requested. Given how the reset control
>>> is used, I think this driver could also use
>>> devm_reset_control_get_shared() to potentially allow sharing a reset
>>> line with other devices.
>> devm_reset_control_get() is a wrapper for devm_reset_control_get_exclusive().
>> Code as below:
>> static inline struct reset_control *devm_reset_control_get(
>>                                 struct device *dev, const char *id)
>> {
>>         return devm_reset_control_get_exclusive(dev, id);
>> }
>> Am i missing something else?
> Obviously you're missing the comment above of_reset_control_get about
> some functions being compatibility wrappers.

Oops, so sorry totally missed/overlooked that. Will update in v3. Thanks.

Regards,
Rahul
