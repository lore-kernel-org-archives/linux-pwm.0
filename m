From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/2] drivers: pwm: pwm-atmel: add support for pwm on
 sama5d2
Date: Mon, 27 Feb 2017 17:23:59 +0200
Message-ID: <99294e68-5503-6ea0-6b6d-c0c29c3bfd81@microchip.com>
References: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
 <1487839120-13650-2-git-send-email-claudiu.beznea@microchip.com>
 <20170223091607.j5yfz7jvfzeinrap@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from exsmtp03.microchip.com ([198.175.253.49]:33723 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbdB0P2D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Feb 2017 10:28:03 -0500
In-Reply-To: <20170223091607.j5yfz7jvfzeinrap@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,
Please ignore this patch also. I will resend it after
switching to atomic PWM.

Thank you,
Claudiu Beznea


On 23.02.2017 11:16, Alexandre Belloni wrote:
> On 23/02/2017 at 10:38:39 +0200, Claudiu Beznea wrote:
>> Enable PWM on sama5d2 by adding atmel_pwm_config_v3().
>> This, simply, sets the period and duty factor registers.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
>> ---
>>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt |  1 +
>>  drivers/pwm/pwm-atmel.c                             | 16 ++++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> index 02331b9..c8c831d 100644
>> --- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>    - compatible: should be one of:
>>      - "atmel,at91sam9rl-pwm"
>>      - "atmel,sama5d3-pwm"
>> +    - "atmel,sama5d2-pwm"
>>    - reg: physical base address and length of the controller's registers
>>    - #pwm-cells: Should be 3. See pwm.txt in this directory for a
>>      description of the cells format.
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 0e4bd4e..4406639 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -207,6 +207,15 @@ static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>>  	}
>>  }
>>  
>> +static void atmel_pwm_config_v3(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				unsigned long dty, unsigned long prd)
>> +{
>> +	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>> +
>> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
>> +	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
>> +}
>> +
>>  static int atmel_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>>  				  enum pwm_polarity polarity)
>>  {
>> @@ -295,6 +304,10 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
>>  	.config = atmel_pwm_config_v2,
>>  };
>>  
>> +static const struct atmel_pwm_data atmel_pwm_data_v3 = {
>> +	.config = atmel_pwm_config_v3,
>> +};
>> +
>>  static const struct platform_device_id atmel_pwm_devtypes[] = {
>>  	{
>>  		.name = "at91sam9rl-pwm",
>> @@ -316,6 +329,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>>  		.compatible = "atmel,sama5d3-pwm",
>>  		.data = &atmel_pwm_data_v2,
>>  	}, {
>> +		.compatible = "atmel,sama5d2-pwm",
>> +		.data = &atmel_pwm_data_v3,
>> +	}, {
>>  		/* sentinel */
>>  	},
>>  };
>> -- 
>> 2.7.4
>>
