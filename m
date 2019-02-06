From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Wed, 6 Feb 2019 09:54:05 +0100
Message-ID: <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com, Tomasz Duszynski <tduszyns@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
> If you agree with the current approach, I can send a V2 with Tomasz's
> suggestion to remove the ifdefs and use __maybe_unused instead.

I think the suspend callback should have something like:

	if (is_still_enabled) {
		/*
		 * The consumer didn't stop us, so refuse to suspend.
		 */
		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
		return -EBUSY;
	}

This way there are no bad surprises if the pwm is suspended before its
consumer and it's obvious what is missing.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
