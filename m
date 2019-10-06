From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: Fix kerneldoc for apply operation
Date: Sun, 6 Oct 2019 21:48:33 +0200
Message-ID: <20191006194833.6r2fujpx36smhwey@pengutronix.de>
References: <20191006044326.12043-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191006044326.12043-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sat, Oct 05, 2019 at 09:43:26PM -0700, Bjorn Andersson wrote:
> As the @state passed to apply() is now const the comment in the
> kerneldoc about drivers being expected to adjust the parameters is no
> longer valid. Update it to reflect the API change.
> 
> Fixes: 71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This is a duplicate of https://patchwork.ozlabs.org/patch/1171851/.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
