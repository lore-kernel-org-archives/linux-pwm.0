From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Date: Fri, 22 Feb 2019 10:27:53 +0100
Message-ID: <20190222092753.jv5yzuqiijp4lqys@pengutronix.de>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
 <20190221204503.w2xh4rw6rh4e5rg4@pengutronix.de>
 <12a63031-596c-77a3-f10c-be276d75e82c@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <12a63031-596c-77a3-f10c-be276d75e82c@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu.Beznea@microchip.com
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Feb 22, 2019 at 09:07:57AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 21.02.2019 22:45, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 19, 2019 at 10:09:00AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> > I wonder how the naming of the defines is chosen given that pwm_data_v3
> > is the first that needs PWM_MAXV2_PRD. Looks inconsistent.
> =

> I know... I'm aware of that. The thing is controllers may differ with
> regards to in-flight duty update and now there is this new difference w/
> regards to counters size.
> =

> Renaming the objects of type atmel_pwm_data in something like
> atmel_pwm_data_<chip-name> as you suggested before would make things clear
> for you?

Yes. Naming stuff after the first SoC that hat the respective
feature/quirk/property should be fine.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
