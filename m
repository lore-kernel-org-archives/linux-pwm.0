From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
Date: Fri, 15 Apr 2016 09:29:00 +0100
Message-ID: <20160415082900.GC3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec>
 <20160413102554.GQ8094@x1>
 <20160413152229.GC29509@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160413152229.GC29509@ulmo.ba.sec>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pwm@vger.kernel.org

On Wed, 13 Apr 2016, Thierry Reding wrote:

> On Wed, Apr 13, 2016 at 11:25:54AM +0100, Lee Jones wrote:
> > On Tue, 12 Apr 2016, Thierry Reding wrote:
> >=20
> > > On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > > > Once a PWM Capture has been initiated, the capture call
> > > > enables a rising edge detection IRQ, then waits.  Once each
> > > > of the 3 phase changes have been recorded the thread then
> > > > wakes.  The remaining part of the call carries out the
> > > > relevant calculations and passes back a formatted string to
> > > > the caller.
> > > >=20
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > index 82a69e4..8de9b4a 100644
> > > > --- a/drivers/pwm/pwm-sti.c
> > > > +++ b/drivers/pwm/pwm-sti.c

[...]

> > > > +	/* Prepare capture measurement */
> > > > +	d->index =3D 0;
> > > > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISI=
NG);
> > > > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > > > +	ret =3D wait_event_interruptible_timeout(d->wait, d->index > =
1, HZ);
> > >=20
> > > The timeout here should make sure callers don't hang forever. But=
 maybe
> > > you can still make sure that when the PWM gets disabled the wait =
queue
> > > is woken and perhaps return an appropriate error code to let user=
s know
> > > that the operation was interrupted.
> >=20
> > Sure.  I'll look into that.
> >=20
> > > Also, how about letting callers choose the value of the timeout? =
In some
> > > cases they may be interested in long-running signals. In other ca=
ses the
> > > whole second timeout may be much too long.
> >=20
> > I'm not opposed to it.  How do you suggest we do that?
>=20
> The easiest would probably be to add an unsigned long timeout paramet=
er
> to the pwm_capture() function and ->capture() callbacks.
>=20
> But thinking about this further I'm wondering if it might not be easi=
er
> and more flexible to move the timeout completely outside of this code
> and into callers. I suspect that the most simple way to do that would=
 be
> to add a completion to struct pwm_capture that callers can use to wai=
t
> for completion of a capture. This would make the whole process
> asynchronous and allow interesting things like making the sysfs captu=
re
> file pollable, for example.

Okay, so how do you propose we handle this with sysfs?  Perhaps
another RW file to set it?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
