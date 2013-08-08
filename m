Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
Date: Thu, 08 Aug 2013 14:27:07 -0700 (PDT)
Message-ID: <1914245.MWaKtJIXGf@flatron>
In-Reply-To: <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <4144776.HcbubHMX0J@flatron> <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On Thursday 08 of August 2013 10:13:27 Andrew Bresticker wrote:
> > ..it should not be defined as non-static in this case (= an ifdef is
> > needed in this header). I believe I had this already fixed, not sure
> > what happened with the fix...
> 
> Perhaps this is it: https://patchwork.kernel.org/patch/2787271/.  That
> should probably land with this patchset too.

Oh yes, this is it.

I know what happened now. This series was already queued for 3.11 in 
Samsung tree. After a bit of testing in linux-next Bart found the build 
error and sent a fix, which was going to be merged for 3.11 as well. 
However since there have been some problems just before merge window 
started, this series had to be dropped, including the fixup patch.

Thanks for reporting. Let me try to sort this out.

Best regards,
Tomasz
