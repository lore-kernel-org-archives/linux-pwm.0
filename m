From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep
 state
Date: Wed, 20 Feb 2019 15:26:37 +0100
Message-ID: <20190220142637.xxlhq7x6sqt4cwzd@pengutronix.de>
References: <1550668068-9661-1-git-send-email-fabrice.gasnier@st.com>
 <1550668068-9661-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550668068-9661-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 20, 2019 at 02:07:46PM +0100, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state on STM32 LPTimer PWM.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

nitpick (i.e. no need to resend): Your Signed-off-by should be the last
thing in your commit log. Assuming your patch ends in mainline in the
end with Thierry taking it it should be

	Signed-off-by: Fabrice
	Reviewed-by: Rob
	Signed-off-by: Thierry

if it was Thierry who added Rob's Reviewed-by tag and it should be

	Reviewed-by: Rob
	Signed-off-by: Fabrice
	Signed-off-by: Thierry

if it was you.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
