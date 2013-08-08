Return-Path: <abrestic@google.com>
MIME-Version: 1.0
Sender: abrestic@google.com
In-Reply-To: <4144776.HcbubHMX0J@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
	<1374623475.SoL01ZHzWk@flatron>
	<CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
	<4144776.HcbubHMX0J@flatron>
Date: Thu, 8 Aug 2013 10:13:27 -0700
Message-ID: <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
Subject: Re: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
From: Andrew Bresticker <abrestic@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

> ..it should not be defined as non-static in this case (= an ifdef is
> needed in this header). I believe I had this already fixed, not sure what
> happened with the fix...

Perhaps this is it: https://patchwork.kernel.org/patch/2787271/.  That
should probably land with this patchset too.

Thanks,
Andrew
