From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for
 device defined in dt
Date: Wed, 21 Jan 2015 15:18:37 +0200
Message-ID: <54BFA72D.5040006@mentor.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com> <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com> <20141107134848.GB31950@ulmo> <545CD4DC.4030409@mentor.com> <545CDDF5.70905@mentor.com> <547C7F8A.40707@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:46452 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbAUNSt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Jan 2015 08:18:49 -0500
In-Reply-To: <547C7F8A.40707@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>

Hello Thierry,

On 01.12.2014 16:47, Vladimir Zapolskiy wrote:
> Hello Thierry,
> 
> On 07.11.2014 16:57, Vladimir Zapolskiy wrote:
>> Thierry,
>>
>> On 07.11.2014 16:19, Vladimir Zapolskiy wrote:
>>> Hi Thierry,
>>>
>>> On 07.11.2014 15:48, Thierry Reding wrote:
>>>> On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
>>>>> Platform PWM backlight data provided by board's device tree should be
>>>>> complete enough to successfully request a pwm device using pwm_get() API.
>>>>>
>>>>> Based on initial implementation done by Dmitry Eremin-Solenikov.
>>>>>
>>>>> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
>>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>>>> Cc: Jingoo Han <jg1.han@samsung.com>
>>>>> Cc: Bryan Wu <cooloney@gmail.com>
>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>> ---
>>>>>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
>>>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> I don't really understand what this is supposed to do. The commit
>>>> message doesn't make a very good job of explaining it either.
>>>>
>>>> Can you describe in more detail what problem this fixes and why it
>>>> should be merged?
>>>
>>> thank you for review.
>>>
>>> As it is shown by the code this particular change rejects fallback to
>>> legacy PWM device request (which itself in turn is fixed in the next
>>> commit) for boards with supplied DTS, "pwm-backlight" compatible node
>>> and unregistered corresponding PWM device in that node.
>>>
>>> I don't know if there is a good enough reason to register PWM backlight
>>> device connected to some quite arbitrary PWM device, if no PWM device
>>> information is given in the "pwm-backlight" compatible node, so I think
>>> it makes sense to change the default policy.
>>>
>>
>> also please note that
>> Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
>> quite fairly describes "pwms" as a required property, but right now this
>> statement from the documentation is wrong, it is possible to register
>> pwm-backlight device driver (using notorious pwm_request() legacy API)
>> connected to some unspecified pwm device.
>>
>> I don't think that the current registration policy is correct, that's
>> why I propose to fix the logic instead of making a documentation update.
>>
> 
> have you had a chance to check the rationale of the change?
> 
> If you accept it, should I make the commit message more verbose?

any updates? Do you have plans to merge the change?

--
With best wishes,
Vladimir
