From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv2] pwm: avoid holding mutex in interrupt context
Date: Wed, 20 Jan 2016 15:32:20 +0100
Message-ID: <20160120143220.GA31427@ulmo>
References: <1453064517-12315-1-git-send-email-linux.amoon@gmail.com>
 <569C2AE8.6070100@samsung.com>
 <CANAwSgT3rXRBVFUQmogkPQwRY93CO0FRFwx_NGjWTHrD5LGbVg@mail.gmail.com>
 <569C69F4.7000906@samsung.com>
 <CANAwSgSMRL2Us6kCHih5c-s6bFdQfEg=xAcdC2v67PjZAHNOTg@mail.gmail.com>
 <569EC6F6.1020505@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569EC6F6.1020505@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 08:29:58AM +0900, Krzysztof Kozlowski wrote:
> On 20.01.2016 00:04, Anand Moon wrote:
> > Hi Krzysztof,
> >=20
> > On 18 January 2016 at 09:58, Krzysztof Kozlowski
> >>> Already within function pwm_samsung_set_invert is protected by
> >>> spin_lock_irqsave(&samsung_pwm_lock, flags);
> >>>
> >>> So no need to introduce another lock to control pwm_samsung_set_polar=
ity.
> >>>
> >>> Best Regards.
> >>> -Anand Moon
> >>
> >> I don't have any clue what is your point here. I don't get what
> >> pwm_samsung_set_polarity has to do with main pwm core...
> >>
> >> Sorry, you need to be more specific.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> >=20
> > Below is the mapping of calls from pwm driver.
> > I have tried to map the functionality and I am trying to understand
> > the flow of the driver.
> >=20
> > Also looking in document
> >=20
> > https://www.kernel.org/doc/Documentation/pwm.txt
> >=20
> > pwm-samsung driver controls the LEDS, fans...etc
> >=20
> > Form the dts modes pwmleds
> >=20
> >         pwmleds {
> >                 compatible =3D "pwm-leds";
> >=20
> >                 blueled {
> >                         label =3D "blue:heartbeat";
> >                         pwms =3D <&pwm 2 2000000 0>;
> >                         pwm-names =3D "pwm2";
> >                         max_brightness =3D <255>;
> >                         linux,default-trigger =3D "heartbeat";
> >                 };
> >         };
> >=20
> > Following is the map out from the device tree.
> >=20
> > pwms =3D <&pwm 2 2000000 0>;
> >=20
> > &pwm       ->  pwm: pwm@12dd0000 --->samsung,exynos4210-pwm
> > 2              ->  period
> > 2000000    ->  duty_cycle
> > 0              ->  polarity
>=20
> I do not see any relations between DTS and the problem.
>=20
> >=20
> > And here is the mapping of the call of function
> > Note: This function call are as per my understanding of the flow in
> > the driver. I might be wrong.
> >=20
> > pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
> > *pwm, enum pwm_polarity polarity)
> > \
> >  pwm_samsung_set_invert(our_chip, pwm->hwpwm, invert);
> >  \
> >   pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polarity)
>=20
> No, pwm_samsung_set_invert does not call pwm_set_polarity(). This would
> result in a circular call - back to pwm_samsung_set_polarity().
>=20
> >   \
> >    pwm->chip->ops->set_polarity(pwm->chip, pwm, polarity);
> >     \
> >      pwm_enable(struct pwm_device *pwm) or pwm_disable(struct pwm_devic=
e *pwm)
> >=20
> > pwm_enable or pwm_disable will be triggered on change in pwm->flags by
> > the pwm core.
> > before pwm_set_polarity is called form the Samsung driver it hold with
> > following locks
> >=20
> > Here is the locking
> >=20
> > pwm_samsung_set_polarity(struct pwm_chip *chip, struct pwm_device
> > *pwm, enum pwm_polarity polarity)
> >  \
> >   pwm_samsung_set_invert(struct samsung_pwm_chip *chip, unsigned int
> > channel, bool invert)
> >     \
> >      spin_lock_irqsave(&samsung_pwm_lock, flags);
> >       \
> >        pwm_set_polarity(struct pwm_device *pwm, enum pwm_polarity polar=
ity)
> >        \
> >         mutex_lock(&pwm->lock)
> >=20
> >           pwm_enable(struct pwm_device *pwm) or pwm_disable(struct
> > pwm_device *pwm)
> >           \
> >            mutex_lock(&pwm->lock);
> >=20
> > Problem I see that we are holding the lock in interrupt context.
> > I don't know how the this triggers this bug.
> >=20
> > BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:97
>=20
> So leave it. If your flow of calls was correct, you would spot the
> problem. But actually it does not matter - I think the flow is not correc=
t.

The reason for the BUG that you're seeing is that the leds-pwm driver
differentiates between PWMs that can sleep and those that can't. This
used to be limited to some PWMs that were attached to a slow bus like
I2C, or that called functions which might sleep (like clk_prepare()).
With commit d1cd21427747 ("pwm: Set enable state properly on failed
call to enable"), effectively all PWM drivers may sleep. The lock
introduced in that commit must also be a mutex because it protects
sections which may sleep themselves (->enable() and ->set_polarity())
so turning it into a spinlock won't work for the general case.

Given that this is currently broken and we're quite close to -rc1 I
suggest the following fix for now:

--- >8 ---
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d24ca5f281b4..7831bc6b51dd 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -889,7 +889,7 @@ EXPORT_SYMBOL_GPL(devm_pwm_put);
   */
 bool pwm_can_sleep(struct pwm_device *pwm)
 {
-	return pwm->chip->can_sleep;
+	return true;
 }
 EXPORT_SYMBOL_GPL(pwm_can_sleep);
=20
--- >8 ---

For v4.6 I can remove all usage of the ->can_sleep and pwm_can_sleep()
because they're effectively useless now.

Does that sound reasonable to everyone?

Anand, the above should fix the issue for you. Can you give it a try
and report if it doesn't?

Thanks,
Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWn5pwAAoJEN0jrNd/PrOhyu0P/jnwVLaLZs0MJryCTjV87c3A
e/LS0FzWA2d4pc7dLCKXSPC1fvIocE3xDieKkNg0l+DdtYX00Ih5Kv5FIMMxeTCL
3OlOuUhi/fxTf/HVjgrT8i6C8l9lZ+Hy2i09V8wB3T9oLF5aiDiBUxYorrfJPpSe
8oEtJu+r3Zng2doGBwKuz/lsoWSUxHaA7tGqdjKPvQVzWcIV350JmMYhrscQTKTp
0lTodnm3I+CVWyZEtcWogcWzIVQwBuvmwT8LzwSiDmAbzXMJQ6Xls7CaoXaXEDoT
UFPSeDh93k+of0FYQFkQUj4fZ51RnMK2d1e1BcMxRehhwvwW3Bx8fShjnDhu3qk2
koRS8IYIri2Z00mKl0dKFUoA/wE+/7/MPiqAXb0oCRwYENhAIq5cdmpWarmJRw/e
zEmjUlPvSztGxkpPckvmBFTJkmT+RBnDp9pOGoV7b1hKJNscyhxheeOkB3ogLtCC
+cJJJoc7ATYWGTYClVvAucCOG6inSgO/tOJUMZe87ms79a5Fk2vdwPEw9hTtIatA
1BjYPeA2jFZhNTZqwvzli+w7rN1KjWtXUSPMyuWMkcTVZcvPsiWoY8EAXFMP80In
l29sWjZUm5Zc5GkDUPkdJqtrq+hhfKwo1g4gjlgszzwGZ7R5U728aJ3T3JXb3R4u
DeD9lrzK0rSUOu/MANrk
=JIUb
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
