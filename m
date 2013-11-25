Return-Path: <shawn.guo@linaro.org>
Date: Mon, 25 Nov 2013 21:37:02 +0800
From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
Message-ID: <20131125133659.GA30476@S2101-09.ap.freescale.net>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
Return-Path: shawn.guo@linaro.org
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org

On Mon, Nov 25, 2013 at 11:26:53AM -0200, Fabio Estevam wrote:
> Looks like we need to apply this one to make sure backlight works:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826

But per Thierry's comment below, this is the exactly the case that we
should avoid - patch individual board DTS file to add a dummy/fake
regulator to get it through.

| But even so, the regulator core now has functionality to return a dummy
| regulator if none is specified in DT, specifically so that users don't
| have to special case the handling of "optional" regulators. That should
| be enough to keep all boards working even if no power-supply property
| was given in the DTS. As a matter of fact it's a constellation that I
| explicitly tested and found to work well.

Shawn
