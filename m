From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 3/4] pwm: tegra: Add DT binding details to configure
 pin in suspends/resume
Date: Thu, 6 Apr 2017 22:18:18 +0530
Message-ID: <58E67152.1080400@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com> <1491488461-24621-4-git-send-email-ldewangan@nvidia.com> <f43c83a9-8ae0-73b0-d41d-97d3bc6c253e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f43c83a9-8ae0-73b0-d41d-97d3bc6c253e-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On Thursday 06 April 2017 08:56 PM, Jon Hunter wrote:
> On 06/04/17 15:21, Laxman Dewangan wrote:
>> In some of NVIDIA Tegra's platform, PWM controller is used to
>> control the PWM controlled regulators. PWM signal is connected to
>> the VID pin of the regulator where duty cycle of PWM signal decide
>> the voltage level of the regulator output.
>>
>> The tristate (high impedance of PWM pin form Tegra) also define
> s/form/from/
> s/define/defines/
>
>> one of the state of PWM regulator which needs to be configure in
>> suspend state of system.
> It maybe clearer to say that when the system enters suspend the
> regulator requires the pwm output to be tristated.

Not necessarily that every PWM regulator interfaces needs it.  It 
depends on the devices.
So I will say:

When system enters suspend, in some of PWM regulator interface, it is 
required to to set the PWM output to be tristated.


>   	pwm: pwm@7000a000 {
> @@ -29,3 +42,33 @@ Example:
>   		resets = <&tegra_car 17>;
>   		reset-names = "pwm";
>   	};
> +
> +
> +Example with the pin configuration for suspend and resume:
> +=========================================================
> +Pin PE7 is used as PWM interface.
> Nit-pick. On what devices? Sounds like this is verbatim. Maybe state
> what device this is an example for.

Let me phrase it as:
Suppose pin PE7 (On tegra210) interfaced with the regulator device and 
this requires PWM output to be tristated when system enters suspend.
Following will be DT binding to achieve this:
