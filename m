From: Tom Hebb <tommyhebb@gmail.com>
Subject: Re: [PATCH RESEND] pwm: berlin: Don't use broken prescaler values
Date: Tue, 5 Jun 2018 12:48:51 -0400
Message-ID: <75f1a632-80c3-1d99-8405-01fa9a4c2616@gmail.com>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1528137144.git.tommyhebb@gmail.com>
 <20180605091002.GB20649@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605091002.GB20649@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, jszhang@marvell.com, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 06/05/2018 05:10 AM, Thierry Reding wrote:
> On Mon, Jun 04, 2018 at 02:32:41PM -0400, Thomas Hebb wrote:
>> Six of the eight prescaler values available for Berlin PWM are not true
>> prescalers but rather internal shifts that throw away the high bits of
>> TCNT. Currently, we attempt to use those high bits, leading to erratic
>> behavior. Restrict the prescaler configurations we select to only the
>> two that respect the full range of TCNT.
>>
>> Tested on BG2CD.
>>
>> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
>> ---
>>  drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> Antoine, Jisheng,
> 
> can you guys review this patch? I'm personally on the fence about this,
> even if we can technically do the shift in software, I don't necessarily
> see a reason why we can't "offload" to the hardware.
> 
> Thierry

Sorry if my commit message was unclear: this patch doesn't just
arbitrarily change the hw/sw division of responsibility. The driver in
its current state is broken (at least on BG2CD), and this patch
implements a fix.

The reason the middle six prescaler values are useless is because they
do not actually slow down the clock. Instead, they emulate slowing down
the clock by internally multiplying TCNT.

This would be a fine trick, if not for the fact that the internal TCNT
value has no extra bits beyond the 16 already exposed to software by the
register. What this means is that, for a prescaler of 4, the software
must ensure that the top two bits of TCNT are not set, because hardware
will chop them off; for a prescaler of 8, the top three bits must not be
set, and so forth. Software does not currently ensure this, resulting in
a TCNT several orders of magnitude lower than intended any time one of
those six prescalers are selected.

Because hardware chops off the high bits in its internal shift, the
middle six prescalers don't actually allow *anything* that the first
doesn't. In fact, they are strictly worse than the first, since the
internal shift of TCNT prevents software from setting the low bits,
decreasing the resolution, without providing any extra high bits.

By skipping the useless prescalers entirely, this patch actually
increases the driver's performance, since, when the 4096 prescaler is
selected, it now does only a single shift rather than the seven
successive divisions it did before.

Let me know if any of this is still unclear, or if you'd like me to
revise the commit message.

-Tom
