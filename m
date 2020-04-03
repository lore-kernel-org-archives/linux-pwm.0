From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Fri, 3 Apr 2020 14:21:38 +0530
Message-ID: <5dbdbc15-ff29-f577-0632-6a28378b0104@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <20200401182833.GB2978178@ulmo>
 <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
 <20200401213738.GA3052587@ulmo>
 <20200402140221.bjbol77uegjma6oz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200402140221.bjbol77uegjma6oz@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org



On 02/04/20 7:32 PM, Uwe Kleine-König wrote:
> Hello Thierry,
> 
> On Wed, Apr 01, 2020 at 11:37:38PM +0200, Thierry Reding wrote:
>> On Wed, Apr 01, 2020 at 10:31:56PM +0200, Uwe Kleine-König wrote:
>>> There are people out there that are more demanding. If you have 1000000
>>> machines in the field and only then find out that they all fail to
>>> operate correctly with a certain small but positive probability and you
>>> have to send someone to each machine to fix that, that's bad.
>>
>> Agreed. But that's not really what we're talking about here, right? This
>> isn't some undefined behaviour that would spontaneously trigger.
>> We're still talking about deterministic behaviour that's going to be
>> the same whether you do it once in a test lab or a million times in
>> the field. A PWM-controlled backlight that you adjust the brightness
>> of in the lab is going to work the same way as in the field. Any
>> potential glitch would be happening in the lab as well. It would in
>> fact, constantly happen.
> 
> The glitch we're talking about really doesn't happen that often that we
> should rely on this problem popping up during testing. To change both
> period and duty_cycle two register writes are necessary. The hickup only
> happens if after the first register write a period ends before the
> second register write hits the hardware. (For the omap driver it might
> happen a bit more often, don't remember the details, but I think the
> above is what could be reached theoretically.)
> 
>> For the rare cases where you can't fake it, it doesn't really matter
>> whether the framework refuses to do something because it knows that the
>> hardware isn't capable of doing it, or whether the driver will simply
>> try its best to do what it was asked to do and fails to deliver. You'll
>> notice one way or another and then you need to go back to the drawing
>> board and redo the design.
> 
> I think you didn't understand up to now that the glitch depends on
> timing between register access and the PWM period and so is really hard
> to actually reproduce. In the hope you understood that now, I assume you
> see that your argumentation is incomplete.
> 
> And I think to assume that somebody would complain about a race
> condition in a patch that just hit next is quite optimistic.
> 
> Having said that I don't know how critical this really is. Given that
> the PWM under discussion doesn't complete periods on stop, it probably
> isn't.

It is a limitation with the existing driver as well. Nothing is being changed
regarding stopping of PWM. The same is marked under the limitations in the driver.

> 
> I spend some time thinking about when the glitch actually happens.
> Currently the load value is written first and then the match value.
> If no period ends between the two writes there is only a problem when in
> the currently running period the match event didn't happen yet. Then we
> see a cycle with
> 
>    .period = oldperiod + newperiod
>    .dutycycle = oldperiod + newdutycycle
> 
> (if the new match value isn't hit in the current cycle) or one with
> 
>    .period = oldperiod
>    .duty_cycle = newdutycycle + (oldperiod - newperiod)
> 
> (if the new match value is hit in the current cycle). The probability
> that one of the two happen is: olddutycycle / oldperiod which is quite
> probable. (With olddutycycle = oldperiod there is no problem though.)
> 
> If after writing the new load value and before writing the new match
> value a period ends it might happen that we see a cycle with
> 
>   .period = newperiod
>   .dutycycle = olddutycycle + (newperiod - oldperiod)
> 
> (if the previous match value is used) or one with
> 
>   .period = 2 * newperiod
>   .dutycycle = newperiod + newdutycycle
> 
> (if new match value is written too late for the first cycle with the new
> period).


That's exactly why we have marked in the Limitations sections that the current
period might produce a cycle with mixed settings.  Frankly, I'm a bit torn here.
There are other PWMs inside Linux with  similar limitations and documented
similarly. If there is an overall objection for such hardware, the entire policy
should be changed or the framework should be updated to allow user to choose for
dynamic updates. IMHO, this series should not be blocked for this decision.
Please consider it for the coming merge window.

Thanks and regards,
Lokesh
