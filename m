From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v10 00/12] Convert PWM period and duty cycle
 to u64
Date: Tue, 31 Mar 2020 14:48:04 +0100
Message-ID: <20200331134804.xxrjaestztcazalc@holly.lan>
References: <cover.1584650604.git.gurus@codeaurora.org>
 <20200321114703.GB4672@kadam>
 <20200330191506.GA29534@codeaurora.org>
 <20200330202636.njjo4savgzf3g6yx@holly.lan>
 <20200330210012.GA27611@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200330210012.GA27611@codeaurora.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>, "Wesley W. Terpstra" <wesley@sifive.com>, Michael Turquette <mturquette@baylibre.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, Atish Patra <atish.patra@wdc.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-riscv@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>, Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>, NXP Linux Team <linux-imx@nxp.com>, Mukesh Ojha <mojha@codeaurora.org>, Gerald Baeza <gerald.baeza@st.com>, intel-gfx@lists.freedesktop.org, Dan
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 02:00:12PM -0700, Guru Das Srinagesh wrote:
> On Mon, Mar 30, 2020 at 09:26:36PM +0100, Daniel Thompson wrote:
> > On Mon, Mar 30, 2020 at 12:15:07PM -0700, Guru Das Srinagesh wrote:
> > > On Sat, Mar 21, 2020 at 02:47:03PM +0300, Dan Carpenter wrote:
> > > > This is a giant CC list.
> > > 
> > > Yes, this is because I received feedback [1] on an earlier patchset
> > > directing me to add the reviewers of patches to the cover letter as
> > > well so that they get some context for the patch.
> > > ...
> > > [1] https://www.spinics.net/lists/linux-pwm/msg11735.html
> > 
> > Strictly speaking I only asked for backlight maintainers to be Cc:ed.
> > I was fairly careful to be specific since I'm aware there are a variety
> > of differing habits when putting together the Cc: list for covering
> > letters.
> > 
> > With the original patch header the purpose of the patch I was Cc:ed on
> > was impossible to determine without the covering letter.
> 
> I suspect this might be the case for all the other reviewers as well -
> that they also would appreciate context for the specific patch they are
> being added to review.
> 
> I wasn't entirely sure what the convention was, so I applied your
> suggestion to all the files. How do you suggest I handle this in my next
> patchset? I fully agree that such a large CC list does look really
> ungainly.

IHMO there should not be a mechanical convention. Instead your goal
needs to be how to make it as easy as possible to review your patches.

Think about it this way: Each person in the To: of a patch (and maybe
also Cc: depending on how you construct things) is a person you are
asking to review and comment on the patch. If that person will find it
easier to review the patch if they are included in the cover letter then
either they should be included or you should improve the patch
description of the patch itself (sometimes both).

Either way it is about optimizing the patchset for readability. More
people read them than write them.


Daniel.
