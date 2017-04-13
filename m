From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: tegra: Set maximum pwm clock source per SoC
 tapeout
Date: Thu, 13 Apr 2017 22:47:12 +0530
Message-ID: <58EFB298.6090206@nvidia.com>
References: <1492092628-843-1-git-send-email-ldewangan@nvidia.com> <1492092628-843-2-git-send-email-ldewangan@nvidia.com> <20170413152738.GB27388@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170413152738.GB27388-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On Thursday 13 April 2017 08:57 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Apr 13, 2017 at 07:40:28PM +0530, Laxman Dewangan wrote:
>> The PWM hardware IP is taped-out with different maximum frequency
>> on different SoCs.
>>
>>  From HW team:
>> 	For Tegra210, it is 38.4MHz.
>> 	For Tegra186, it is 102MHz.
>>
>> Add support to limit the clock source frequency to the maximum IP
>> supported frequency. Provide these values via SoC chipdata.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/pwm/pwm-tegra.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
>> index 8c6ed55..7016c08 100644
>> --- a/drivers/pwm/pwm-tegra.c
>> +++ b/drivers/pwm/pwm-tegra.c
>> @@ -41,6 +41,9 @@
>>   
>>   struct tegra_pwm_soc {
>>   	unsigned int num_channels;
>> +
>> +	/* Maximum IP frequency for given SoCs */
>> +	unsigned long max_frequency;
>>   };
>>   
>>   struct tegra_pwm_chip {
>> @@ -204,6 +207,24 @@ static int tegra_pwm_probe(struct platform_device *pdev)
>>   	/* Read PWM clock rate from source */
>>   	pwm->clk_rate = clk_get_rate(pwm->clk);
>>   
>> +	/* Make sure clock source freqeuncy must less than IP supported */
>> +	if (pwm->soc->max_frequency &&
>> +	    (pwm->soc->max_frequency < pwm->clk_rate)) {
>> +		ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "Failed to set max frequency: %d\n",
>> +				ret);
>> +			return ret;
>> +		}
>> +
>> +		/*
>> +		 * The requested and configured frequency may differ due to
>> +		 * clock register resolutions. Get the configured frequency
>> +		 * so that PWM period can be calculated more accurately.
>> +		 */
>> +		 pwm->clk_rate = clk_get_rate(pwm->clk);
>> +	}
> Is there a reason to conditionalize this? Couldn't we simply set the
> clock to the maximum frequency in all cases? Higher frequency means
> higher precision, right?

I think higher precision is not related directly to maximum frequency. 
Precision will much depends on the perfect multiples between period and 
clock source frequency.

If some usecases needed the perfect periods then the clock source 
frequency can be set via clock init table for clock driver to achieve 
the perfect PWM period. on this case, we should not change it in the PWM 
driver.
PWM driver should only worry about to limit the maximum.



>   So just something like this perhaps:
>
> 	ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> 	if (ret < 0) {
> 		...
> 	}
>
> 	pwm->clk_rate = clk_get_rate(pwm->clk);
>
> That of course means that we'd need to define a maximum frequency for
> SoCs prior to Tegra210. Any chance we can get at them?


Getting information for the older SoCs are little bit difficult. Let me 
try if possible from HW team.

Otherwise, What we can do now as we can make 38.4MHz till T210 and 102M 
for T186.


>> +
>>   	pwm->rst = devm_reset_control_get(&pdev->dev, "pwm");
>>   	if (IS_ERR(pwm->rst)) {
>>   		ret = PTR_ERR(pwm->rst);
>> @@ -275,12 +296,19 @@ static const struct tegra_pwm_soc tegra20_pwm_soc = {
>>   	.num_channels = 4,
>>   };
>>   
>> +static const struct tegra_pwm_soc tegra210_pwm_soc = {
>> +	.num_channels = 4,
>> +	.max_frequency = 38400000UL, /* 38.4MHz */
>> +};
>> +
>>   static const struct tegra_pwm_soc tegra186_pwm_soc = {
>>   	.num_channels = 1,
>> +	.max_frequency = 102000000UL, /* 102MHz */
> I don't think we need these comments, it's fairly obvious what
> frequencies you're specifying there. =)
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
