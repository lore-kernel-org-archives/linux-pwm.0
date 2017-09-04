From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm_bl: Fix overflow condition
Date: Mon, 4 Sep 2017 16:16:12 +0100
Message-ID: <20170904151612.bbhb4qrbkut77lyi@dell>
References: <20170829203434.6826-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829203434.6826-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com, jingoohan1@gmail.com, briannorris@chromium.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 29 Aug 2017, Derek Basehore wrote:

> This fixes an overflow condition that can happen with high max
> brightness and period values in compute_duty_cycle. This fixes it by
> using a 64 bit variable for computing the duty cycle.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied for v4.15, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
