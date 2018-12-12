Return-path: <kernel-bounces@pengutronix.de>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 12 Dec 2018 03:13:54 +0000
Message-ID: <OSBPR01MB2293D189DCEA1EFB89A1AC34D8A70@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20181207214932.xckuuarcka733v7y@pengutronix.de> <1828832.OCLkmioh6N@avalon>
 <OSBPR01MB2293ED3087627127A1A884A4D8A50@OSBPR01MB2293.jpnprd01.prod.outlook.com>
 <20181210080413.6367nhxhoj6ecqhl@pengutronix.de>
In-Reply-To: <20181210080413.6367nhxhoj6ecqhl@pengutronix.de>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: pwm: rcar: improve calculation of divider
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Uwe,

> From: Uwe Kleine-K=F6nig, Sent: Monday, December 10, 2018 5:04 PM
>=20
> Hello,
>=20
> On Mon, Dec 10, 2018 at 05:09:31AM +0000, Yoshihiro Shimoda wrote:
> > Thank you very much for your patches!
> > I tested patches and both codes work correctly.
>=20
> \o/, that's actually better than I expected :-)
>=20
> > > > The value of div should be calculatable without a loop. Something l=
ike:
> > > >
> > > >    divider =3D NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
> > > >    tmp =3D (unsigned long long)period_ns * clk_rate + (divider - 1)=
;
> > > >    do_div(tmp, divider);
> >
> > This should be do_div64_u64() because the divider is 1,023,000,000,000 =
(over 32-bits).
>=20
> Yes, I think Laurent did this part right.
>=20
> > > >    div =3D ilog2(tmp - 1) + 1;
> > > >
> > > > You might want to check if my maths are right, I didn't test.
> > >
> > > I've noticed the same, and wrote the following patch last week, also =
untested.
> > > I was planning to give it a try before sending it out, but as you've =
noticed
> > > the same issue, here's the code if anyone wants to give it a try befo=
re I can.
> > > Our calculations are similar, the main difference is the last line, a=
nd I
> > > think yours read better.
> >
> > So, I'd like to apply Uwe's code to mainline. Uwe, may I send such a pa=
tch
> > with your author and Singed-off-by?
>=20
> Please no, I cannot sing good enough for this :-)
>=20
> Honestly: If you take the authorship and write something like "Algorithm
> suggested by Uwe Kleine-K=F6nig and Laurent Pinchart" that's IMHO fine.

Thank you for your reply. I got it. I'll make a patch with such comment :)

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
