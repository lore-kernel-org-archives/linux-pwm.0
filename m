Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 11 Dec 2018 22:26:58 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PWM: drop legacy wrapper for changing polarity
Message-ID: <20181211212658.vxxci7npev2dnjou@pengutronix.de>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
 <20181120165758.pwprvrhzpftkghap@pengutronix.de>
 <20181130085942.epcatcj3zeegprz6@pengutronix.de>
 <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Thu, Dec 06, 2018 at 10:20:57AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Thierry,
>=20
> On Fri, Nov 30, 2018 at 09:59:42AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Nov 20, 2018 at 05:57:58PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Sun, Nov 04, 2018 at 10:19:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Hello Thierry,
> > > >=20
> > > > On Mon, Oct 15, 2018 at 10:21:52AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > The API to configure a PWM using pwm_enable(), pwm_disable(),
> > > > > pwm_config() and pwm_set_polarity() is superseeded by atomically =
setting
> > > > > the parameters using pwm_apply_state(). To get forward with depre=
cating
> > > > > the former set of functions use the opportunity that there is no =
current
> > > > > user of pwm_set_polarity() and remove it.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > >=20
> > > > I think this patch is undisputed and wonder if it fell through the
> > > > cracks given that a patch sent later made it into your pwm/for-4.20=
-rc1
> > > > pull request.
> > >=20
> > > Now that you pushed out my lpc patch to your for-next branch (thanks!=
),
> > > I wonder what you plan to do with this patch.
> >=20
> > Ping! There are also a few other patches that didn't catch your
> > attention yet:
> >=20
> >  - series for pwm-imx starting with
> >    "pwm: imx: remove if block where the condition is always wrong"
> >  - "pwm: don't use memcmp to compare struct state variables"
> >  - "pwm: drop per-chip dbg_show callback"
>=20
> In a different thread it was suggested to resend the patches instead of
> sending a ping. Should I do that? There are also
>=20
>  - pwm: rearrange structures to group members by purpose
>  - [RFC] Documentation: pwm: rework documentation for the framework
>=20
> which didn't get any feedback from you yet.
>=20
> There is a patchwork instance for the pwm list[1]. Are you using that?
> It seems to be orphaned for some time but was already used this year.
> Would you accept some help here? E.g.=20
>=20
>  - https://patchwork.ozlabs.org/patch/1001130/
>    -> superseeded as there is a v3
>  - https://patchwork.ozlabs.org/patch/993022/
>    -> rejected is probably right
>  - https://patchwork.ozlabs.org/patch/860540/
>    -> applied as bb084c0f61d659f0e6d371b096e0e57998f191d6
>  - https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D72798
>    -> rejected

It's sad to not get any feedback from you, and I'm not the only one
waiting for a reply. Linux is at -rc6 and there is only a single patch
in your (visible) queue for the next merge window although there are
some patches that look ready for application on the list.

I guess it's lack of time that keeps you from caring more for the pwm
stuff. If you need help (e.g. by caring for the patchwork todo list) I'm
willing to spend some time. If it helps you I can also collect the
patches that I think are ok and provide a pull request to your tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
