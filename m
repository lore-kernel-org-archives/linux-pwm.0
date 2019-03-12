From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add
 Allwinner sun8i.
Date: Tue, 12 Mar 2019 13:03:19 +0800
Message-ID: <CAJeuY7_gx=PBhF4t40nCCWia-aq1G3t9D9nKS7ejOh56t2RkHQ@mail.gmail.com>
References: <20181125161859.GA5277@arx-s1> <20181220175009.GF9408@ulmo> <CAJeuY7-StNNDpBPyw1JH5Jmc-NhDw67F6Veh0S2tBTmENCTY8Q@mail.gmail.com>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDKITZOARQMBBJH3TTSAKGQEIIUPXGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAJeuY7-StNNDpBPyw1JH5Jmc-NhDw67F6Veh0S2tBTmENCTY8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

---------- Forwarded message ---------
From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: 2019=E5=B9=B43=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=
=8812:59
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner s=
un8i.
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=88=
21=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:50=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > This patch adds Allwinner sun8i pwm binding document.
> >
> > Signed-off-by: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++=
++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > new file mode 100644
> > index 0000000..7531d85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > @@ -0,0 +1,24 @@
> > +Allwinner sun8i R40/V40/T3 SoC PWM controller
> > +
> > +Required properties:
> > +  - compatible: Should be one of:
> > +    - "allwinner,sun8i-r40-pwm"
> > +  - reg: Physical base address and length of the controller's register=
s
> > +  - interrupts: Should contain interrupt.
> > +  - clocks: From common clock binding, handle to the parent clock.
> > +  - clock-names: Must contain the clock names described just above.
> > +  - pwm-channels: PWM channels of the controller.
>
> Why do you need this? In the cover letter you say:
>
>         "The sun8i R40/T3/V40 PWM has 8 PWM channals ..."
>
> Why does this need to be specified in the DT?

T3 PWM has 8 channals, i think it is necessary to tell user how to
specify it Instead of
hardcode the channal myself :)

Thanks for review :)

>
> Thierry
> -----BEGIN PGP SIGNATURE-----
>
> iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb1k4ACgkQ3SOs138+
> s6EOyA//auHjqjKwvjCLwWgHXdVr26cFUnFn/Ml6ZHHRe+oLCiYsatv4AZfGFvZ7
> CIGWN3zUu9c5YoDOd1isauQYgRtTsShWYC4gPxFFK9hWfb8f3o/wG60whkNDuvLL
> 1SAQ/KJTC01LQIEXfHlb60EPvKCtt4YUQG4PkTGBGOHSO+MhWQHRLy5aLaq+d3yH
> KHaDZ0PuZvYNnFWi7W/ggraiIlRToPH8HanFzGew+gUfPjClrczjrGqgn8u0bAL6
> MuKDMHLgjI/D8cs7XIaXc/OCPsp69B4JGrRJsxYh0KGKthaYDeKAUERpvsltDhGT
> oTB55mJPZlriaiEOSwPrj+M0JQe9AnUIBVEiSIP2dSn8+rcSlWd10ysEjnCH/Ea7
> ARkamiRCk2hgOhZlDZcm+hjh7VxnJinaYahGFXMszpVgCScHT/fjZKexGqX8NJa8
> EWRJjeJaS1jLpLb7ZhM0iZrhzSC638G/5z3+1CWmyxwOvICb0FXzQDCTNSm1t8DO
> NicV26tAWMIvDEW5PcTqrJaSvQmNrr4MiBiqocKs4N+ZA7Ey8JQW0oUFzwiwD6Ew
> HaOuVXDlha1SZNK2tEnTDsTctXefl+eB7xeQ8MOHPp3yeKrpQlj4gHSyNOboEaXR
> 8el/ZC1gGYHPeFGPSgXTbRNFwNY8/9GKPfP5cUgLc+e1B7oWAHg=3D
> =3D9v1O
> -----END PGP SIGNATURE-----

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
