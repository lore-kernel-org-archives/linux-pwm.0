From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 15:16:24 +0200
Message-ID: <5433E7A8.60001@atmel.com>
References: <1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com> <20141007094427.GW25331@lee--X1> <20141007094727.GA12631@ulmo> <20141007095932.GY25331@lee--X1> <20141007100632.GA31575@ulmo> <20141007101743.GA25331@lee--X1> <20141007111304.GA1539@ulmo> <20141007113814.GA3693@lee--X1> <20141007134112.40179e8a@bbrezillon> <20141007115529.GA17434@ulmo> <20141007122224.GD3693@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:35186 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbaJGNQ3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:16:29 -0400
In-Reply-To: <20141007122224.GD3693@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

Hi Lee,

On 07/10/2014 14:22, Lee Jones :
> On Tue, 07 Oct 2014, Thierry Reding wrote:
>> On Tue, Oct 07, 2014 at 01:41:12PM +0200, Boris Brezillon wrote:
>>> On Tue, 7 Oct 2014 12:38:14 +0100
>>> Lee Jones <lee.jones@linaro.org> wrote:
>>>
>>>> On Tue, 07 Oct 2014, Thierry Reding wrote:
>>>>
>>>>> On Tue, Oct 07, 2014 at 11:17:43AM +0100, Lee Jones wrote:
>>>>>> On Tue, 07 Oct 2014, Thierry Reding wrote:
>>>>>>
>>>>>>> On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
>>>>>>>> On Tue, 07 Oct 2014, Thierry Reding wrote:
>>>>>>>>
>>>>>>>>> On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
>>>>>>>>>> On Mon, 06 Oct 2014, Boris Brezillon wrote:
>>>>>>>>>>
>>>>>>>>>>> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
>>>>>>>>>>> family or sama5d3 family) exposes 2 subdevices:
>>>>>>>>>>> - a display controller (controlled by a DRM driver)
>>>>>>>>>>> - a PWM chip
>>>>>>>>>>>
>>>>>>>>>>> The MFD device provides a regmap and several clocks (those connected
>>>>>>>>>>> to this hardware block) to its subdevices.
>>>>>>>>>>>
>>>>>>>>>>> This way concurrent accesses to the iomem range are handled by the regmap
>>>>>>>>>>> framework, and each subdevice can safely access HLCDC registers.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>>>>>>>>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>>>>>>>>> Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
>>>>>>>>>>> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  drivers/mfd/Kconfig             |   6 ++
>>>>>>>>>>>  drivers/mfd/Makefile            |   1 +
>>>>>>>>>>>  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++++
>>>>>>>>>>>  4 files changed, 214 insertions(+)
>>>>>>>>>>>  create mode 100644 drivers/mfd/atmel-hlcdc.c
>>>>>>>>>>>  create mode 100644 include/linux/mfd/atmel-hlcdc.h
>>>>>>>>>>
>>>>>>>>>> Applied for v3.19.
>>>>>>>>>
>>>>>>>>> Will you provide a stable branch that I can pull into the PWM tree?
>>>>>>>>
>>>>>>>> I hadn't planned on it.  What do you need that for?
>>>>>>>
>>>>>>> Because the PWM driver depends on this series. But if you prefer you
>>>>>>> could also take the PWM driver through your tree.
>>>>>>
>>>>>> Probably better to deal with that via Kconfig.
>>>>>
>>>>> Do you have any suggestions? The PWM driver currently selects the
>>>>> MFD_ATMEL_HLCDC symbol, which as I understand will cause a Kconfig error
>>>>> if the latter isn't defined.
>>>>
>>>> s/select/depends on/ for the desired effect.
>>>>
>>>
>>> Don't forget the atmel-hlcdc.h header file which is referenced by both
>>> the DRM and the PWM drivers.
>>
>> The depends on will prevent the PWM driver from being built until MFD
>> becomes available, so the missing header file shouldn't be a problem.
>>
>> That said, Nicolas Ferre (Cc'ing) at some point requested this to become
>> a select (or at least for the DRM driver, but I guess the same applies
>> to PWM) on the grounds that a depends on will make it more difficult to
>> enable the driver.
> 
> It's not that much more difficult.  It just entails enabling 3 instead
> of 2 config options.

Yes it is more difficult. Believe me, it's a mess, but...

> Once all of the required components are merged,
> feel free to drop back to 'select'.  This is easier than sharing round
> immutable branches all over the place.

.. I agree with this option of moving to an easier-to-merge solution and
then dealing with the ease of use.

>> So we have two options here: 1) turn the select into a depends on here
>> and allow the dependency to be resolved that way, or 2) solve the
>> dependency by making sure the MFD part is merged first (either by
>> pulling the MFD tree into the PWM and DRM trees or waiting for a full
>> cycle for the MFD changes to land).
>>
>> I don't mind either way.
> 
> I'll go with either of the two suggestions above.

So, Lee and Thierry, you can both take your part in your respective
trees with the change (1) described above and with my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

(if you feel it is needed).

Thanks, bye,
-- 
Nicolas Ferre
