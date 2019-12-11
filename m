From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6 example
Date: Wed, 11 Dec 2019 16:33:19 +0800
Message-ID: <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
References: <20191210174710.10649-1-peron.clem@gmail.com> <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime@cerno.tech>
Cc: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 11, 2019 at 4:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Dec 10, 2019 at 06:47:10PM +0100, Clément Péron wrote:
> > Latest linux-next doesn't build due to the following error:
> >
> > Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dts:35.37-38
> > syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dt.yaml]
> > Error 1
> >
> > This is due to missing header in the device-tree yaml example.
> >
> > Fix this by adding the missing headers.
> >
> > Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description")
> > Reported-by: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
>
> Applied, thanks!
> Maxime

Maybe squash it instead? :)

ChenYu
