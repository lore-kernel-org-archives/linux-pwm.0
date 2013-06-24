Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Date: Mon, 24 Jun 2013 20:31:43 +0200
Message-ID: <1888817.YsvuAKkSk2@flatron>
In-Reply-To: <20130624174903.GA6795@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <51C86442.6090406@samsung.com> <20130624174903.GA6795@mithrandir>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Monday 24 of June 2013 19:49:04 Thierry Reding wrote:
> On Tue, Jun 25, 2013 at 12:22:42AM +0900, Kukjin Kim wrote:
> > On 06/22/13 22:06, Tomasz Figa wrote:
> > >This patch introduces new Samsung PWM driver, which is heavily
> > >cleaned,
> > >multiplatform aware and supports DeviceTree based instantiation.
> > >
> > >Since on historical hardware PWM block can be shared with clocksource
> > >driver, a shared spinlock is used to protect access to shared
> > >registers, already exported from the clocksource driver.
> > >
> > >Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> > >---
> > >
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-samsung.c | 601
> > >  ++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed,
> > >  602 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-samsung.c
> > >
> > >Changes since v2:
> > >  - Replaced __raw_{readl,writel} with {readl,writel}.
> > >  - Corrected commit message.
> > 
> > [...]
> > 
> > >+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, 
val)
> > >{
> > >+		if (val>= SAMSUNG_PWM_NUM) {
> > >+			pr_warning("%s: invalid channel index in 
samsung,pwm-outputs
> > >property\n",> 
> > Just note, checkpatch complains following, so fixed to use pr_warn()
> > when I applied.
> 
> Note that you can't apply patches that touch the PWM tree without my Ack
> and I already mentioned that the current way this driver is written
> isn't acceptable.
> 
> So either you fix it properly, or if everybody except me thinks we don't
> need a proper design for drivers anymore, then the only way I'll accept
> this driver into the PWM tree is if you put a really big comment at the
> top of the file saying that the driver is badly designed on purpose and
> that people shouldn't be using it as a reference.

Sorry, I don't understand what problem you have with this design. It 
completely meets all the requirements applicable on hardware platforms it 
is (and going to be) used on.

The only thing it would do in a suboptimal way would be synchronization of 
register accesses for multiple instances of the driver - one spinlock 
would be used for all of them. This is insignificant because there is no 
time critical code in this driver and it is really unlikely that a SoC 
with multiple instances of this IP block shows up.

Channel reservation between clocksource and PWM drivers is completely 
correct, relying on the fact that the former can only use channels 
_without_ outputs and the latter can only use channels _with_ outputs. Do 
I have to add that there can't be a channel both with and without output?

So the only place for improvement here, without starting overengineering 
things, is a comment about the purpose of the spinlock and why it can be 
used in our case.

Best regards,
Tomasz
