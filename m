From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32: Fix the usage of uninitialized variable in
 stm32_pwm_config()
Date: Fri, 4 Oct 2019 08:23:36 +0200
Message-ID: <20191004062336.jidzrytx4z5talro@pengutronix.de>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004044649.2405-1-yzhai003@ucr.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Yizhuo <yzhai003@ucr.edu>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Oct 03, 2019 at 09:46:49PM -0700, Yizhuo wrote:
> Inside function stm32_pwm_config(), variable "psc" and " arr"
> could be uninitialized if regmap_read() returns -EINVALs.
> However, they are used later in the if statement to decide
> the return value which is potentially unsafe.
> 
> The same case happens in function stm32_pwm_detect_channels()
> with variable "ccer", but we cannot just return -EINVAL because
> the error code is not acceptable by the caller. Aslo, the variable

s/Aslo/Also/

> "ccer" in functionstm32_pwm_detect_complementary() could also be

s/functionstm32_pwm_detect_/function stm32_pwm_detect_/

> uninitialized, since stm32_pwm_detect_complementary() returns void,
> the patch is not easy.

active_channels() is also affected. Also there are calls to
regmap_update_bits which should have their return values checked.

While a patch to fix these all is not trivial it is certainly possible
and I would prefer to fix the problem completely.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
