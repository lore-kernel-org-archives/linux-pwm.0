Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 10 Dec 2018 09:04:13 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: pwm: rcar: improve calculation of divider
Message-ID: <20181210080413.6367nhxhoj6ecqhl@pengutronix.de>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207214932.xckuuarcka733v7y@pengutronix.de>
 <1828832.OCLkmioh6N@avalon>
 <OSBPR01MB2293ED3087627127A1A884A4D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OSBPR01MB2293ED3087627127A1A884A4D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello,

On Mon, Dec 10, 2018 at 05:09:31AM +0000, Yoshihiro Shimoda wrote:
> Thank you very much for your patches!
> I tested patches and both codes work correctly.

\o/, that's actually better than I expected :-)
=20
> > > The value of div should be calculatable without a loop. Something lik=
e:
> > >
> > >    divider =3D NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
> > >    tmp =3D (unsigned long long)period_ns * clk_rate + (divider - 1);
> > >    do_div(tmp, divider);
>=20
> This should be do_div64_u64() because the divider is 1,023,000,000,000 (o=
ver 32-bits).

Yes, I think Laurent did this part right.
=20
> > >    div =3D ilog2(tmp - 1) + 1;
> > >
> > > You might want to check if my maths are right, I didn't test.
> >=20
> > I've noticed the same, and wrote the following patch last week, also un=
tested.
> > I was planning to give it a try before sending it out, but as you've no=
ticed
> > the same issue, here's the code if anyone wants to give it a try before=
 I can.
> > Our calculations are similar, the main difference is the last line, and=
 I
> > think yours read better.
>=20
> So, I'd like to apply Uwe's code to mainline. Uwe, may I send such a patch
> with your author and Singed-off-by?

Please no, I cannot sing good enough for this :-)

Honestly: If you take the authorship and write something like "Algorithm
suggested by Uwe Kleine-K=F6nig and Laurent Pinchart" that's IMHO fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
