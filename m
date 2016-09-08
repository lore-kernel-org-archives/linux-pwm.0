From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pwm: meson: handle unknown ID values
Date: Thu, 08 Sep 2016 11:29:57 +0200
Message-ID: <7923222.muhSLJ29Um@wuerfel>
References: <20160906125106.1511562-1-arnd@arndb.de> <20160908092354.GB24112@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:59136 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcIHJa1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Sep 2016 05:30:27 -0400
In-Reply-To: <20160908092354.GB24112@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

On Thursday, September 8, 2016 11:23:54 AM CEST Thierry Reding wrote:
> On Tue, Sep 06, 2016 at 02:50:47PM +0200, Arnd Bergmann wrote:
> > When building with -Wmaybe-uninitialized, we get a couple of harmless
> > warnings about three functions in this new driver that don't look
> > safe to the compiler:
> > 
> > drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
> > drivers/pwm/pwm-meson.c:355:26: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > drivers/pwm/pwm-meson.c: In function 'meson_pwm_disable':
> > drivers/pwm/pwm-meson.c:263:13: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > drivers/pwm/pwm-meson.c: In function 'meson_pwm_apply':
> > drivers/pwm/pwm-meson.c:231:13: error: 'clk_shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > drivers/pwm/pwm-meson.c:231:36: error: 'enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > drivers/pwm/pwm-meson.c:231:24: error: 'clk_enable' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > 
> > Specifically, if we have a device with an id other than 0 or 1,
> > this would result in undefined behavior. This is currently not
> > possible, but the compiler cannot be expected to know this.
> > 
> > This patch adds a 'default' clause to let the compiler know
> > what to do instead, which shuts up the warning and makes the
> > code slightly more resiliant in case it gets extended to other
> > identifiers.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/pwm/pwm-meson.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> Applied, though I left out the dummy assignment of state->enabled = 0
> because that's dead code anyway.

Sounds good. My first version had "break" instead of "return" there,
so it required the assignment,  but you are in the current version you
are right that we are better off without it.

	Arnd
