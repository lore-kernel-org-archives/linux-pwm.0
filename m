From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 3/4] pwm: tegra: Add DT binding details to configure pin
 in suspends/resume
Date: Thu, 6 Apr 2017 15:03:54 +0100
Message-ID: <0f99b415-5f6f-dc90-244b-f6cc593f9a09@nvidia.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
 <1491401626-31303-4-git-send-email-ldewangan@nvidia.com>
 <33445b27-ae0b-b28e-afca-e7b776b4b7c0@nvidia.com>
 <20170406130315.GB7784@ulmo.ba.sec> <58E6405E.5020402@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18315 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbdDFOEQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 10:04:16 -0400
In-Reply-To: <58E6405E.5020402@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>


On 06/04/17 14:19, Laxman Dewangan wrote:
> 
> On Thursday 06 April 2017 06:33 PM, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Thu, Apr 06, 2017 at 09:57:09AM +0100, Jon Hunter wrote:
>>> On 05/04/17 15:13, Laxman Dewangan wrote:
>>>> +state of the system. The configuration of pin is provided via the
>>>> pinctrl
>>>> +DT node as detailed in the pinctrl DT binding document
>>>> +    Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>>>> +
>>>> +The PWM node will have following optional properties.
>>>> +pinctrl-names:    Pin state names. Must be "suspend" and "resume".
>>> Why not just use the pre-defined names here? There is a pre-defined name
>>> for "default", "idle" and "sleep" and then you can use the following
>>> APIs and avoid the lookup of the state ...
>>>
>>> pinctrl_pm_select_default_state()
>>> pinctrl_pm_select_idle_state()
>>> pinctrl_pm_select_sleep_state()
>>>
>>> Note for i2c [0][1], I used "default" as the active/on state (which I
>>> know is not that descriptive) and then used 'idle' as the suspended
>>> state. This way we don't need any custom names.
>> Agreed, I think that's how these states are meant to be used.
> I did quick grep for the pinctrl_pm_select_* functions in the code tree
> and found usage of these APIs in some of the places.
> I am taking the reference of i2c-st, i2c-nomadic and
> extcon/extcon-usb-gpio.c drivers and from this the interpretation is
> 
> default state: When interface active and transfer need to be done in IO
> interface.
> idle state: Active state of the system but interface is not active, put
> in non-active state of the interface.
> sleep state: When system entering into suspend and IO interface is going
> to be inactive.
> 
> So in PWM case, we will need the "default" and "sleep" state.
> 
> In suspend(), set the "sleep" state and in resume, set the "default" state.
> 
> + Linus W as I refereed his st/nomadik driver for reference.

I mis-spoke before, I used 'idle' for i2c as I am using it in the
context of the runtime-pm callbacks and not suspend. So sleep is fine
with me.

Jon

-- 
nvpublic
