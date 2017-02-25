From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/3] pwm: sunxi: Add A64 support
Date: Sat, 25 Feb 2017 17:23:09 +0800
Message-ID: <870861488014589@web9m.yandex.ru>
References: <20170225074216.64868-1-icenowy@aosc.xyz> <20170225074216.64868-2-icenowy@aosc.xyz> <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBAE2YXCQKGQE2L22YOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org



25.02.2017, 16:53, "Chen-Yu Tsai" <wens-jdAy2FN1RRM@public.gmane.org>:
> On Sat, Feb 25, 2017 at 3:42 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
>> =C2=A0A64 PWM controller has same register layout as sun4i driver, so it=
 works
>> =C2=A0by adding A64 specific data.
>>
>> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>> =C2=A0---
>> =C2=A0=C2=A0drivers/pwm/pwm-sun4i.c | 9 +++++++++
>> =C2=A0=C2=A01 file changed, 9 insertions(+)
>>
>> =C2=A0diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
>> =C2=A0index 1284ffa05921..ca3431e03fb8 100644
>> =C2=A0--- a/drivers/pwm/pwm-sun4i.c
>> =C2=A0+++ b/drivers/pwm/pwm-sun4i.c
>> =C2=A0@@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pwm_=
data_h3 =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.npwm =3D 1,
>> =C2=A0=C2=A0};
>>
>> =C2=A0+static const struct sun4i_pwm_data sun4i_pwm_data_a64 =3D {
>> =C2=A0+ .has_prescaler_bypass =3D true,
>> =C2=A0+ .has_rdy =3D true,
>> =C2=A0+ .npwm =3D 1,
>> =C2=A0+};
>> =C2=A0+
>
> This seems to be tha same as the H3. Any differences between the
> H3 and A64? Otherwise please just use that compatible.

H3 is also same as A13...

See http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486=
595.html

>
> ChenYu
>
>> =C2=A0=C2=A0static const struct of_device_id sun4i_pwm_dt_ids[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.compatible =3D "allwinner,sun4i-a10-pwm",
>> =C2=A0@@ -307,6 +313,9 @@ static const struct of_device_id sun4i_pwm_dt_=
ids[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.compatible =3D "allwinner,sun8i-h3-pwm",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.data =3D &sun4i_pwm_data_h3,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}, {
>> =C2=A0+ .compatible =3D "allwinner,sun50i-a64-pwm",
>> =C2=A0+ .data =3D &sun4i_pwm_data_a64,
>> =C2=A0+ }, {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* sentinel */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
>> =C2=A0=C2=A0};
>> =C2=A0--
>> =C2=A02.11.1
>>
>> =C2=A0--
>> =C2=A0You received this message because you are subscribed to the Google=
 Groups "linux-sunxi" group.
>> =C2=A0To unsubscribe from this group and stop receiving emails from it, =
send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
>> =C2=A0For more options, visit https://groups.google.com/d/optout.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
