From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v10 00/12] Convert PWM period and duty cycle to u64
Date: Mon, 30 Mar 2020 14:00:12 -0700
Message-ID: <20200330210012.GA27611@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
 <20200321114703.GB4672@kadam>
 <20200330191506.GA29534@codeaurora.org>
 <20200330202636.njjo4savgzf3g6yx@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200330202636.njjo4savgzf3g6yx@holly.lan>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, "Wesley W. Terpstra" <wesley@sifive.com>, Michael Turquette <mturquette@baylibre.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, Atish Patra <atish.patra@wdc.com>, Thierry Reding <thierry.reding@gmail.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Alexandre Torgue <alexandre.torgue@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>, Fabio Estevam <festevam@gma>
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 09:26:36PM +0100, Daniel Thompson wrote:
> On Mon, Mar 30, 2020 at 12:15:07PM -0700, Guru Das Srinagesh wrote:
> > On Sat, Mar 21, 2020 at 02:47:03PM +0300, Dan Carpenter wrote:
> > > This is a giant CC list.
> > 
> > Yes, this is because I received feedback [1] on an earlier patchset
> > directing me to add the reviewers of patches to the cover letter as
> > well so that they get some context for the patch.
> > ...
> > [1] https://www.spinics.net/lists/linux-pwm/msg11735.html
> 
> Strictly speaking I only asked for backlight maintainers to be Cc:ed.
> I was fairly careful to be specific since I'm aware there are a variety
> of differing habits when putting together the Cc: list for covering
> letters.
> 
> With the original patch header the purpose of the patch I was Cc:ed on
> was impossible to determine without the covering letter.

I suspect this might be the case for all the other reviewers as well -
that they also would appreciate context for the specific patch they are
being added to review.

I wasn't entirely sure what the convention was, so I applied your
suggestion to all the files. How do you suggest I handle this in my next
patchset? I fully agree that such a large CC list does look really
ungainly.

Thank you.

Guru Das.
