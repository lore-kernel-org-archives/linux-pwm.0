From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Fri, 24 Apr 2020 15:14:22 -0700
Message-ID: <20200424221422.GA31118@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200423114857.GG3612@dell> <20200423215306.GA8670@codeaurora.org>
 <20200424064303.GJ3612@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200424064303.GJ3612@dell>
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

On Fri, Apr 24, 2020 at 07:43:03AM +0100, Lee Jones wrote:
> A great deal of mailing lists contain numerous protections against
> things like flooding and spamming.  One of those protections is a
> check for "Too many recipients to the message".  Most of the time this
> simply requires moderator intervention by way of review and approval,
> but this ultimately depends on the ML's configuration.
> 
> The first thing to ascertain is why your recipients list is so large.
> Have you added every reviewer, subsystem-maintainer, maintainer and
> contributor suggested by get-maintainer.pl?  If so, consider pruning
> that a little.  Contributors do not tend to care about subsequent
> changes to a file.  As someone who receives a lot of patches, I tend
> to get fed-up when receiving patches simply because I made a change X
> years ago.  Stick to listed maintainers/reviewers in the first
> instance and see how far that takes you.

Thank you for the detailed reply. I did this in the first few patchsets
and then when a few patches didn't get any attention, expanded the
audience thus. Still, around 50% of the patches in this series remain
unreviewed by anyone.

> If your recipients list is as succinct as reasonably possible, maybe
> just accept that every version isn't going to be archived by every
> ML.  It's still much more useful for the correct people to have
> visibility into the set than for it to be archived multiple times.

Thank you, will prune the list and remove past contributors from the
Cc-list and add all parties to all patches.

Thank you.

Guru Das.
