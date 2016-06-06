From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 10/14] regulator: pwm: Switch to the atomic PWM API
Date: Mon, 6 Jun 2016 11:44:59 +0530
Message-ID: <575514E3.7050802@nvidia.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>	<1464942192-25967-11-git-send-email-boris.brezillon@free-electrons.com>	<20160603205028.GH124478@google.com> <20160604082848.0b897b14@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7621 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFFG1q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jun 2016 02:27:46 -0400
In-Reply-To: <20160604082848.0b897b14@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com


On Saturday 04 June 2016 11:58 AM, Boris Brezillon wrote:
> On Fri, 3 Jun 2016 13:50:28 -0700
> Brian Norris <briannorris@chromium.org> wrote:
>
>> + Laxman
>>
>> Hi,
>>
>> On Fri, Jun 03, 2016 at 10:23:08AM +0200, Boris Brezillon wrote:
>>> -	 * calculation loss.
>>> -	 */
>>> -	req_period = req_diff * pargs.period;
>>> -	div_u64_rem(req_period, diff, &rem);
>>> -	if (!rem) {
>>> -		do_div(req_period, diff);
>>> -		duty_pulse = (unsigned int)req_period;
>>> -	} else {
>>> -		duty_pulse = (pargs.period / 100) * ((req_diff * 100) / diff);
>>> -	}
>>> +	/* We pass diff as the scale to get a uV precision. */
>>> +	pwm_set_relative_duty_cycle(&pstate, req_diff, diff);
>> Notably, you're dropping much of Laxman's commit fd786fb0276a ("regulator:
>> pwm: Try to avoid voltage error in duty cycle calculation"), but I
>> believe the DIV_ROUND_CLOSEST_ULL() in pwm_set_relative_duty_cycle()
>> solves his problem better.
> Oops, forgot to comment on that in the commit message. Indeed, the use
> of pwm_set_relative_duty_cycle() solves the problem Laxman was seeing.
>
Yaah, the issue which I was seeing and had fix will be resolved with 
this also.
I wanted to do req_diff * period first before any scaling/division.

Function pwm_set_relative_duty_cycle() does the same,  and hence it is fine.

state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)val * state->period,
+                          scale);



Acked-by: Laxman Dewangan <ldewangan@nvidia.com>



Thanks,
Laxman
