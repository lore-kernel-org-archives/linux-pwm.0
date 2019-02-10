From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
Date: Sun, 10 Feb 2019 22:33:20 +0100
Message-ID: <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
 <20190209162133.65e6fd93@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190209162133.65e6fd93@archlinux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, vilhelm.gray@gmail.com, thierry.reding@gmail.com, mcoquelin.stm32@gmail.com, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Feb 09, 2019 at 04:21:33PM +0000, Jonathan Cameron wrote:
> On Tue, 5 Feb 2019 13:40:29 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> =

> > Add suspend/resume PM sleep ops. When going to low power, disable
> > active counter. Only active counter should be resumed: don't touch
> > disabled counter, as it may be used by other LPTimer MFD child driver.
> > =

> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I think this looks fine.  I'm not totally sure if patches 3,4 are
> separable from 1,2 though so please let me know whether I should take
> these now, or let all 4 go in together via some path?

I'd say these are orthogonal, so if you are happy with patches 3 and 4
you can take them without bothering for patches 1 and 2.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
