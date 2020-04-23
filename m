From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Thu, 23 Apr 2020 14:53:06 -0700
Message-ID: <20200423215306.GA8670@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200423114857.GG3612@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Atish Patra <atish.patra@wdc.com>, Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 12:48:57PM +0100, Lee Jones wrote:
> What's the merge plan for this set?

I'm not sure what you mean. My assumption is that first all the patches
need to get an Acked-by and only then will the series get applied by
Thierry... Could Thierry or Uwe weigh in on this point please?

> FYI, it's better to send all patches to all parties.  That way
> maintainers and interested persons can follow the discussion and
> progress, or lack there of.

Something I noticed with adding all the various mailing lists to the CC
list for this cover letter is that it is causing this cover letter email
and all its replies to not be archived properly on spinics or lore -
it's probably getting rejected by email filters somehow. Compare with
v12 [1] where I'd pruned the list considerably as an experiment - that
got archived correctly.

Any ideas on what might be going wrong? Once I fix this I can add all
parties to all patches knowing that there would be no issues in mail
archival.

[1] https://www.spinics.net/lists/linux-pwm/msg12131.html

Thank you.

Guru Das.
