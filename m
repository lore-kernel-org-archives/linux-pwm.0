From: Pascal Roeleven <dev@pascalroeleven.nl>
Subject: Re: pwm: sun4i: pwm-backlight not working since 5.6-rc1
Date: Thu, 12 Mar 2020 16:06:07 +0100
Message-ID: <6e995c4c22c4e6c93acb1f491e5aa109@pascalroeleven.nl>
References: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
 <20200312132942.2kfspvmoc3mxkdx4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200312132942.2kfspvmoc3mxkdx4@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

On 2020-03-12 14:29, Uwe Kleine-König wrote:
> On Thu, Mar 12, 2020 at 01:22:13PM +0100, Pascal Roeleven wrote:
>> Hi all,
>> 
>> I am working on adding an old A10 device to mainline and noticed an 
>> issue
>> when testing on 5.5.8 vs master.
>> 
>> Since 5.6-rc1, I can't control the brightness of my LCD backlight 
>> anymore.
>> The backlight stays on full brightness instead. I am controlling the
>> brightness value via sysfs for testing.
>> 
>> I am not sure if this is a general pwm-sun4i issue or if it is related 
>> to
>> the backlight. However I narrowed it down to one commit for pwm-sun4i:
>> 
>> fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
>> 
>> If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on
>> master, the backlight works fine. Unfortunately, due to my lack of 
>> kernel
>> experience, I can't see how the commit above broke it.
> 
> Hmm, I cannot see how fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 breaks
> this. Looking at the output of
> 
> 	git show -b fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
> 
> (i.e. ignoring whitespace changes) I don't see how the behaviour you're
> reporting can be explained.
> 
> Are you sure that fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 is the bad
> commit?
> 
> Can you install a tool to inspect register values and check how the
> affected registers change if you switch kernel versions and/or pwm
> settings?
> 
> (e.g.
> 	memtool md 0x1c20e00+0xc
> )
> 
> Best regards
> Uwe

Thanks for your response.

Yes I am sure that is the commit. If I am on master, and replace 
pwm-sun4i.c with the one from 5b090b43, everything works. If I then 
apply fa4d8178, it stops working.

And strangely the output of the registers is exactly the same before and 
after fa4d8178:

01c20e00: 00000050 00130014 00000000 (full brightness)
01c20e00: 00000050 00130006 00000000 (min brightness)

Even when I'm on 5b090b43 and cherry-pick fa4d8178 can I reproduce the 
issue.
