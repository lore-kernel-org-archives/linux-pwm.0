From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure
 pin in suspends/resume
Date: Fri, 7 Apr 2017 08:49:08 +0100
Message-ID: <a73bdb48-f424-2b45-ea0f-99781fd832f3@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
 <1491488461-24621-4-git-send-email-ldewangan@nvidia.com>
 <f43c83a9-8ae0-73b0-d41d-97d3bc6c253e@nvidia.com>
 <58E67152.1080400@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58E67152.1080400-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On 06/04/17 17:48, Laxman Dewangan wrote:
> 
> On Thursday 06 April 2017 08:56 PM, Jon Hunter wrote:
>> On 06/04/17 15:21, Laxman Dewangan wrote:
>>> In some of NVIDIA Tegra's platform, PWM controller is used to
>>> control the PWM controlled regulators. PWM signal is connected to
>>> the VID pin of the regulator where duty cycle of PWM signal decide
>>> the voltage level of the regulator output.
>>>
>>> The tristate (high impedance of PWM pin form Tegra) also define
>> s/form/from/
>> s/define/defines/
>>
>>> one of the state of PWM regulator which needs to be configure in
>>> suspend state of system.
>> It maybe clearer to say that when the system enters suspend the
>> regulator requires the pwm output to be tristated.
> 
> Not necessarily that every PWM regulator interfaces needs it.  It
> depends on the devices.

Yes I understand that. I am just saying the description could be a
little clearer.

> So I will say:
> 
> When system enters suspend, in some of PWM regulator interface, it is
> required to to set the PWM output to be tristated.

Ok, but I think you should say why that is, because from the above
sentence alone it is not clear. Maybe you should say that some PWM
client/slave devices require the PWM output to be tristated.

Jon

-- 
nvpublic
