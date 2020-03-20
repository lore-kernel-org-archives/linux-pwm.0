From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v10 02/12] hwmon: pwm-fan: Use 64-bit division macro
Date: Thu, 19 Mar 2020 18:13:38 -0700
Message-ID: <20200320011338.GA12892@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
 <b8d8e51723f99844abc6a3f637ac42be3e084709.1584650604.git.gurus@codeaurora.org>
 <4c99e36b-4705-a6a2-0769-301b5e9b5006@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4c99e36b-4705-a6a2-0769-301b5e9b5006@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 02:12:02PM -0700, Guenter Roeck wrote:
> On 3/19/20 1:50 PM, Guru Das Srinagesh wrote:
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by using DIV_ROUND_UP_ULL to handle
> > a 64-bit dividend.
> > 
> > Cc: Kamil Debski <kamil@wypas.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: linux-hwmon@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> 
> https://patchwork.kernel.org/patch/11430549/
> 
> includes my previous Ack. v9 included it, in v10 it is dropped.
> I don't see a change in the patch. Please explain.

Sorry, I missed adding the Acked-by and Reviewed-by tags for the all the
patches that have received them in this v10 patchset. I will add them
back and re-push.
