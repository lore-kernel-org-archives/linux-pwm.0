From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
Date: Thu, 15 Nov 2018 22:05:35 +0100
Message-ID: <20181115210535.mxmyjjbpzrjdufsr@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181114123236.GG2620@ulmo>
 <20181115091644.d5hdk5vao6x74zwp@pengutronix.de>
 <20181115162159.GD8611@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181115162159.GD8611@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Nov 15, 2018 at 05:21:59PM +0100, Thierry Reding wrote:
> On Thu, Nov 15, 2018 at 10:16:44AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 14, 2018 at 01:32:36PM +0100, Thierry Reding wrote:
> > > On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > This helps to convert drivers from the legacy API to pwm_apply_stat=
e without
> > > > having to make the aware of the configured polarity (and in some ca=
ses even
> > > > period).
> > > > =

> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  include/linux/pwm.h | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > =

> > > So if I understand your intention correctly here you want consumers to
> > > be able to get at the default state, which would be the state as it w=
as
> > > "configured" in DT or the PWM lookup table so that you can modify that
> > > state (well, really just setting the duty-cycle) before you actually
> > > send the state to the hardware.
> > > =

> > > So the difference to pwm_apply_args() is that you don't want the driv=
er
> > > to specifically program a duty cycle of 0 before setting the actual d=
uty
> > > cycle that you want to set.
> > > =

> > > Is that about right?
> > =

> > Yes, and a resulting advantage is that the apply callback is only called
> > once.
> >  =

> > > Isn't that exactly what pwm_init_state() already does? pwm-backlight
> > > uses it for exactly the same purpose that you seem to be using it in
> > > RX1950 backlight control.
> > =

> > I didn't use pwm_init_state because that doesn't give a helpful value
> > for state->enabled. (I think it is: if the driver provides a get_state
> > callback it is whatever that one set, otherwise it's off.)
> =

> That's correct. It's pretty much the same thing that you have, except
> you explicitly set enable =3D false. But that's not really important
> because consumers are supposed to explicitly override that anyway.

If we hardcode to enable=3Dfalse the call to pwm_get_state could be
dropped, too. Then the two functions are really semantically identical.
> =

> > Also the name pwm_init_state isn't that good IMHO. Just from the name
> > I'd expect it to be something like
> > =

> > 	memset(state, 0, sizeof(&state));
> > =

> > instead of something more informed that depends on hardware state and/or
> > data provided by a device tree.
> =

> Be that as it may, the kerneldoc is pretty explicit about what it does
> and so is the code. Not liking the name shouldn't be an excuse for
> duplicating functionality.

With your suggestion to move the initialisation of ->state into the
core, maybe this function can go away from the public API such that the
naming doesn't really matter (and can be adapted easily).

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
