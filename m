From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Wed, 22 Apr 2020 16:37:55 -0700
Message-ID: <20200422233755.GA11597@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <20200422084934.ajh6yzs5mkzzvop4@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200422084934.ajh6yzs5mkzzvop4@holly.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Atish Patra <atish.patra@wdc.com>, Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Philipp
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 22, 2020 at 09:49:34AM +0100, Daniel Thompson wrote:
> On Tue, Apr 21, 2020 at 07:57:12PM -0700, Guru Das Srinagesh wrote:
> > [REQUEST]
> > 
> > Would it be possible for the patches that have already received Acked-by's in
> > this series to be accepted and applied to the tree? I lost an Acked-by (in
> > intel-panel.c) because it had a merge conflict with a new change that came in
> > after I rebased to tip. I wasn't sure earlier about accepting single patches as
> > opposed to the entire series en masse, but this event has got me thinking.
> 
> Has there been a positive maintainer review of patch 11 at any point in
> the thread (most of the people you are asking to commit patches have
> not been able to see the discussion about the actual feature these
> patches are preparing for)?

Yes. Uwe had this to say [1] about a previous patchset (v5) of patch 11
which is essentially unchanged in this patchset save the dropping of the
pwm_capture change.

[1] https://www.spinics.net/lists/linux-pwm/msg11536.html

Thank you.

Guru Das.
