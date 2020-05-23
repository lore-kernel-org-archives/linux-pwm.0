From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date: Sat, 23 May 2020 22:01:25 +0200
Message-ID: <20200523200125.khdw3eau5eakxqy6@pengutronix.de>
References: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
 <20190919111115.5oraof2bdl4627xv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190919111115.5oraof2bdl4627xv@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: David Wu <david.wu@rock-chips.com>
Cc: linux-pwm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello David,

On Thu, Sep 19, 2019 at 01:11:15PM +0200, oUwe Kleine-K=F6nig wrote:
> On Thu, Sep 19, 2019 at 11:17:27AM +0200, Rasmus Villemoes wrote:
> > The way state->enabled is computed is rather convoluted and hard to
> > read - both branches of the if() actually do the exact same thing. So
> > remove the if(), and further simplify "<boolean condition> ? true :
> > false" to "<boolean condition>".
> > =

> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> > I stumbled on this while trying to understand how the pwm subsystem
> > works. This patch is a semantic no-op, but it's also possible that,
> > say, the first branch simply contains a "double negative" so either
> > the !=3D should be =3D=3D or the "false : true" should be "true : false=
".
> =

> The change looks obviously right, it's a noop.
> =

> I share your doubts however. The construct was introduced in commit =

> 831b2790507b ("pwm: rockchip: Use same PWM ops for each IP") by David
> Wu.
> =

> Before there were rockchip_pwm_get_state_v1 for the supports_polarity =3D
> false case and rockchip_pwm_get_state_v2 for supports_polarity =3D true.
> =

> In both state->enabled was assigned true if ((val & enable_conf) =3D=3D
> enable_conf). So I assume everything is fine.
> =

> A confirmation by David would be great though.

This is still open. Can you please have a look at
https://patchwork.ozlabs.org/project/linux-pwm/patch/20190919091728.24756-1=
-linux@rasmusvillemoes.dk/
and verify it's correct?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
