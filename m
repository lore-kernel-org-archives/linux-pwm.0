Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 12 Dec 2018 11:59:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] PWM: drop legacy wrapper for changing polarity
Message-ID: <20181212105902.jcgc2hi42mwkhqzm@pengutronix.de>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
 <20181120165758.pwprvrhzpftkghap@pengutronix.de>
 <20181130085942.epcatcj3zeegprz6@pengutronix.de>
 <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
 <20181211212658.vxxci7npev2dnjou@pengutronix.de>
 <20181212102547.GN15092@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181212102547.GN15092@ulmo>
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

Hello Thierry,

On Wed, Dec 12, 2018 at 11:25:47AM +0100, Thierry Reding wrote:
> I certainly wouldn't mind a little help. Reviewing patches will
> definitely help move things along.

I already did. Apart from my patch series noted before:

 - series for pwm-imx starting with
   "pwm: imx: remove if block where the condition is always wrong"
 - "pwm: don't use memcmp to compare struct state variables"
 - "pwm: drop per-chip dbg_show callback"

I think the following patches are ready for application:

 - [v3] pwm: kconfig: enable kona pwm to be built for cygnus arch
 - [13/17] pwm: bcm2835: Switch to SPDX identifier

As I only recently subscribed to the linux-pwm list I don't have the
older patches listed on
https://patchwork.ozlabs.org/project/linux-pwm/list/ in my inbox. Just
grabbed Michal's imx get_state series from there and replied.

Other than that feedback to my RFC doc patch would be great. One thing I
didn't mention there is: Is pwm_disable supposed to wait for the current
period to end? I'd say yes (even though it might make sense to have the
possibility to stop immediately in some cases).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
