From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/8] Add support for H6 PWM
Date: Tue, 10 Dec 2019 10:48:14 -0600
Message-ID: <CAL_JsqJevcG2qv+BYKTnP=out0jPxuEcdYuLq7idxK04Q05fag@mail.gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com> <20191121072408.GE4345@gilmour.lan>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJIP47K7MERBW4YX7XQKGQESUKEU7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191121072408.GE4345-2DbqMqoCcjvhXIiyNabO3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org>
Cc: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Nov 21, 2019 at 1:24 AM Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org> wrote:
>
> On Tue, Nov 19, 2019 at 06:53:11PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > This is a rework of Jernej's previous work[1] taking account all the
> > previous remarks.
> >
> > Bindings is still strict but probe in the driver are now optionnals.
> >
> > If someone could confirm that the PWM is not broken, as my board
> > doesn't output it.
> >
> > I didn't add the acked-tags as there are big changes.
>
> Applied 1 and 7 for 5.6, thanks!

I believe patch 7 breaks linux-next:

Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.exampl=
e.dts:35.37-38
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.example.dt.yaml]
Error 1

Usually that's due to a missing include.

Rob

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAL_JsqJevcG2qv%2BBYKTnP%3Dout0jPxuEcdYuLq7idxK04Q05fag%40mail=
.gmail.com.
