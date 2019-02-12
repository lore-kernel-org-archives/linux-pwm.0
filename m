From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Date: Tue, 12 Feb 2019 10:03:04 +0100
Message-ID: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Fabrice,

On Tue, Feb 12, 2019 at 09:31:37AM +0100, Fabrice Gasnier wrote:
> On 2/11/19 8:06 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> >> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *=
dev, struct device_node *np,
> >>  	if (!IS_ERR(pwm)) {
> >>  		*ptr =3D pwm;
> >>  		devres_add(dev, ptr);
> >> +		device_link_add(dev, pwm->chip->dev,
> >> +				DL_FLAG_AUTOREMOVE_CONSUMER);
> > =

> > IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
> > + devres stuff. I'd put device_link_add() into of_pwm_get().
> =

> Hi Uwe,
> =

> I also agree with this. But I think this implies modifying the API for
> of_pwm_get():
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
> + * @dev: device for PWM consumer
>   * @np: device node to get the PWM from
>   * @con_id: consumer name
> =

> It seems there aren't much of_pwm_get() users currently.
> Does this look sensible ?

In my eyes this looks sensible, yes.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
