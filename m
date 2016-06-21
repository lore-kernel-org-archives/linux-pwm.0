From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in
 lpc32xx_pwm_disable
Date: Wed, 22 Jun 2016 00:57:23 +0300
Message-ID: <c2b2d8f7-8e9a-c61b-45c9-5a588d3cc761@mleia.com>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <b499570f-e624-cbe1-4fca-44ba0e701054@mleia.com>
 <1466512742.2114.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:38673 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbcFUV51 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 21 Jun 2016 17:57:27 -0400
In-Reply-To: <1466512742.2114.9.camel@localhost>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Hi Sylvain,

On 21.06.2016 15:39, Sylvain Lemieux wrote:
> Hi Vladimir,
> 
> On Tue, 2016-06-21 at 05:11 +0300, Vladimir Zapolskiy wrote:
>> Hi Sylvain,
>>
>> On 03.06.2016 22:37, Sylvain Lemieux wrote:
>>> From: Sylvain Lemieux <slemieux@tycoint.com>
>>>
>>> If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
>>> disable the PWM, the PWM output is always set as a logic 1.
>>>
>>> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
>>> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
>>> and a 0 logic level was apply to the output.
>>>
>>> According to the LPC32x0 User Manual [1],
>>> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
>>>
>>> This change initialize the pin level to 0 (default value) and
>>> update the register value accordingly during the disable process.
>>>
>>> [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
>>>
>>> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
>>
>> It looks like a pin control setting, but because it depends
>> on PWM enabled/disabled status, I suppose it is good enough to
>> manage it from the PWM driver.
>>
>> I think here a new optional DTS property should be introduced,
>> which if present indicates that PWM_OUT pin value is high when
>> PWM is disabled. And if the property is not found then
>> PWMx_PIN_LEVEL is set to 0 on driver probe.
>>
> I will add this option and submit a new revision of the patch.
> 
>> By convention the property name should be prefixed by "nxp,",
>> what name is good? May be "nxp,pwm-disabled-level-high" ?
>> Or add a property "nxp,pwm-disabled-level" with valid values 0/1?
>>
> I prefer to use "nxp,pwm-disabled-level-high".
> 

nice, for v2 please add documentation devicetree bindings bits and
add devicetree mailing list to Cc, hopefully Rob will find time
to review the name.

Have you tried to set PWMx_PIN_LEVEL only once on probe()?
I think there is no need to set/unset it every time when PWM is
enabled or disabled. If it works, then the newly introduced local
state storage can be removed.

>> Also note someone may want to switch the default behaviour
>> in runtime, but this feature may be added later on.
>>
> I agree with you, this can be done later.


--
With best wishes,
Vladimir
