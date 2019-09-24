Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 24 Sep 2019 14:00:08 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] [RFC] Documentation: pwm: rework documentation for
 the framework
Message-ID: <20190924120008.m3l4qsyhmuyfssnl@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
 <20190107194938.3004-5-u.kleine-koenig@pengutronix.de>
 <20190726093912.q6m6syroot2eqie6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190726093912.q6m6syroot2eqie6@pengutronix.de>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Fri, Jul 26, 2019 at 11:39:12AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Thierry,
>=20
> On Mon, Jan 07, 2019 at 08:49:43PM +0100, Uwe Kleine-K=F6nig wrote:
> > This is a draft for an in my eyes improved documentation describing
> > consumers, providers and backend drivers of the PWM framework.
> >=20
> > The bigger changes include:
> >=20
> >  - sysfs description is split into a separate document (otherwise uncha=
nged)
> >  - Only the new style functions and callbacks are described; the legacy
> >    stuff is just mentioned shortly in a dedicated paragraph.
> >  - The expectations for the different callbacks (most importantly .appl=
y)
> >    are mentioned explicitly.
> >=20
> > There is a gap in the documentation because I didn't understand the
> > .capture callback. There is no documentation about it, just two drivers
> > implementing it. I guess it is about measuring an input signal, so it s=
eems
> > to be misplaced in the PWM framework which otherwise is just about an
> > output pin.
>=20
> I'm still waiting for feedback here. AFAICT there is nothing that should
> be controversial as I intended to just describe the status quo.

This patch doesn't apply any more since

	baa293e9544b ("docs: driver-api: add a series of orphaned documents")

. (The respective patch didn't make it to the linux-pwm list.)

Do you consider it worthwhile to update the patch? Should the sysfs
stuff live under Documentation/driver-api, too?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
