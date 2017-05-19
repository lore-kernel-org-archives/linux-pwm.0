From: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
Subject: [PATCH 00/29] Standardize doc formats - part 3
Date: Thu, 18 May 2017 22:25:44 -0300
Message-ID: <cover.1495157082.git.mchehab@s-opensource.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <rtc-linux+bncBDN2TRMCWQGRBOUT7HEAKGQESX2WDPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: Mauro Carvalho Chehab <mchehab-+2H6TX3emwOR5IQWS55C32Xnswh1EIUO@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Linux Doc Mailing List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kpreempt-tech-5NWGOfrQmneHXe+LvDLADg@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Each document under Documentation/*.txt has its own format.
Some follow markup notations, some don't even have a title!

In order to try to get some order on it, change the document
style to the standard we're adopting after the adoption of
ReStructured Text.

The documents touched on this series now build fine with
Sphinx, if renamed to *.rst extension.

The main goal with this is to teach people by example about
what format is expected on newer documents. It also helps
to add those files to Kernel books.

In order to make things more palatable, I'm spliting the
conversion into three parts.

This is	part 3.

Mauro Carvalho Chehab (29):
  pinctrl.txt: standardize document format
  pnp.txt: standardize document format
  preempt-locking.txt: standardize document format
  printk-formats.txt: standardize document format
  pwm.txt: standardize document format
  rbtree.txt: standardize document format
  remoteproc.txt: standardize document format
  rfkill.txt: standardize document format
  robust-futex-ABI.txt: standardize document format
  robust-futexes.txt: standardize document format
  rpmsg.txt: standardize document format
  rtc.txt: standardize document format
  SAK.txt: standardize document format
  sgi-ioc4.txt: standardize document format
  siphash.txt: standardize document format
  SM501.txt: standardize document format
  smsc_ece1099.txt: standardize document format
  static-keys.txt: standardize document format
  svga.txt: standardize document format
  sync_file.txt: standardize document format
  this_cpu_ops.txt: standardize document format
  unaligned-memory-access.txt: standardize document format
  vfio-mediated-device.txt: standardize document format
  vfio.txt: standardize document format
  video-output.txt: standardize document format
  xillybus.txt: standardize document format
  xz.txt: standardize document format
  zorro.txt: standardize document format
  dell_rbu.txt: standardize document format

 Documentation/SAK.txt                     |   65 +-
 Documentation/SM501.txt                   |    9 +-
 Documentation/dell_rbu.txt                |   81 ++-
 Documentation/pinctrl.txt                 | 1104 +++++++++++++++--------------
 Documentation/pnp.txt                     |  343 +++++----
 Documentation/preempt-locking.txt         |   40 +-
 Documentation/printk-formats.txt          |  416 ++++++-----
 Documentation/pwm.txt                     |   46 +-
 Documentation/rbtree.txt                  |   88 +--
 Documentation/remoteproc.txt              |  320 +++++----
 Documentation/rfkill.txt                  |   47 +-
 Documentation/robust-futex-ABI.txt        |   14 +-
 Documentation/robust-futexes.txt          |   12 +-
 Documentation/rpmsg.txt                   |  340 +++++----
 Documentation/rtc.txt                     |   44 +-
 Documentation/sgi-ioc4.txt                |    4 +
 Documentation/siphash.txt                 |  186 ++---
 Documentation/smsc_ece1099.txt            |    4 +
 Documentation/static-keys.txt             |  199 +++---
 Documentation/svga.txt                    |  146 ++--
 Documentation/sync_file.txt               |   23 +-
 Documentation/this_cpu_ops.txt            |   49 +-
 Documentation/unaligned-memory-access.txt |   57 +-
 Documentation/vfio-mediated-device.txt    |  252 +++----
 Documentation/vfio.txt                    |  261 +++----
 Documentation/video-output.txt            |   54 +-
 Documentation/xillybus.txt                |   29 +-
 Documentation/xz.txt                      |  182 ++---
 Documentation/zorro.txt                   |   59 +-
 29 files changed, 2437 insertions(+), 2037 deletions(-)

-- 
2.9.4


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
