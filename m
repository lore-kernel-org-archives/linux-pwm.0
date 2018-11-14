From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
Date: Wed, 14 Nov 2018 10:15:37 +0100
Message-ID: <20181114091537.bvriiawz3rnamazl@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
 <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPfuUFzFFwJoPutQz+zYqtom8evscpq2=PafX1EbBAnC+Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, reding@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Mon, Oct 29, 2018 at 11:46:15AM +0100, Krzysztof Kozlowski wrote:
> On Fri, 26 Oct 2018 at 20:54, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > The legacy PWM API should be removed in the long run, so convert a user
> > to the atomic PWM API.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/mach-s3c24xx/mach-rx1950.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> =

> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> I see this depends on first patch so I assume this will go through pwm tr=
ee.

Right, I assume so, too. Unfortunately I didn't hear anything back from
Thierry about this because there seems to be a mail reception problem on
his end.

@Thierry: Could you find the problem? It would be great to get some
feedback from you regarding these patches. There are more pwm users that
could benefit from this change, but I first want some feedback about
this before investing more time here.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
