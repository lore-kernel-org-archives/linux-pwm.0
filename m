From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Wed, 22 Jun 2016 13:46:48 -0700
Message-ID: <20160622204647.GA14996@google.com>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
 <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
 <20160621183730.GA130978@google.com>
 <20160622100422.5c34f975@bbrezillon>
 <20160622191658.GA106497@google.com>
 <20160622224114.697c0db5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160622224114.697c0db5@bbrezillon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 22, 2016 at 10:41:14PM +0200, Boris Brezillon wrote:
> On Wed, 22 Jun 2016 12:16:59 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > Notably, you're dropping the 'if (!pwm) { }' safety checks that are part
> > of pwm_disable() and pwm_set_polarity(). But I don't think there should
> > be any users relying on that.
> 
> Indeed. I can add it back here if you prefer,

Nah, that's ok. I just had to say it anyway :)

> but honestly, PWM users
> that are not checking the value returned by pwm_get() should be
> considered buggy IMHO, and a NULL pointer exception is a good way to
> make people realize they are not properly using the API :).

Seems OK.

Brian
