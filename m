Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20131122145224.GO14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
	<20131122145224.GO14725@sirena.org.uk>
Date: Fri, 22 Nov 2013 14:06:49 -0200
Message-ID: <CAOMZO5Bxp5pWxS35N2hGZcpRvM8WueLz3_dNL=EpJQLro4sKVg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
From: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pwm.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org

On Fri, Nov 22, 2013 at 12:52 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Nov 22, 2013 at 03:22:32PM +0100, Thierry Reding wrote:
>
>> Cc'ing Mark Brown, perhaps he can help figure out what's causing this.
>
> The obvious question is what kernel this is being tested on...

Tested linux-next 20131120 originally and display was blank.

Now on 20131122 the display works fine.

Regards,

Fabio Estevam
