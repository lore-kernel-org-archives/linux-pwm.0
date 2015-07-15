From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [v2 1/7] gpiolib: Add support for removing registered consumer
 lookup table
Date: Wed, 15 Jul 2015 10:05:16 +0200
Message-ID: <CACRpkdYOxHn0PBfFauvhiSbSbXCRCZ11fwvdWpgAmkY5-30eDQ@mail.gmail.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
 <1434970465-12687-2-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1434970465-12687-2-git-send-email-shobhit.kumar@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Povilas Staniulis <wdmonster@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, bloften80@gmail.com, linux-gpio <linux-gpio@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCBKdW4gMjIsIDIwMTUgYXQgMTI6NTQgUE0sIFNob2JoaXQgS3VtYXIgPHNob2JoaXQu
a3VtYXJAaW50ZWwuY29tPiB3cm90ZToKCj4gSW4gY2FzZSB3ZSB1bmxvYWQgYW5kIGxvYWQgYSBk
cml2ZXIgbW9kdWxlIGFnYWluIHRoYXQgaXMgcmVnaXN0ZXJpbmcgYQo+IGxvb2t1cCB0YWJsZSwg
d2l0aG91dCB0aGlzIGl0IHdpbGwgcmVzdWx0IGluIG11bHRpcGxlIGVudHJpZXMuIFByb3ZpZGUK
PiBhbiBvcHRpb24gdG8gcmVtb3ZlIHRoZSBsb29rdXAgdGFibGUgb24gZHJpdmVyIHVubG9hZAo+
Cj4gdjI6IENjaW5nIG1haW50YWluZXJzCj4gdjM6IENvcnJlY3QgdGhlIHN1YmplY3QgbGluZSAo
TGVlIGpvbmVzKQo+Cj4gQ2M6IFNhbXVlbCBPcnRpeiA8c2FtZW9AbGludXguaW50ZWwuY29tPgo+
IENjOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Cj4gQ2M6IEFsZXhh
bmRyZSBDb3VyYm90IDxnbnVyb3VAZ21haWwuY29tPgo+IENjOiBUaGllcnJ5IFJlZGluZyA8dGhp
ZXJyeS5yZWRpbmdAZ21haWwuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4YW5kcmUgQ291cmJvdCA8
YWNvdXJib3RAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMu
d2FsbGVpakBsaW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFNob2JoaXQgS3VtYXIgPHNob2Jo
aXQua3VtYXJAaW50ZWwuY29tPgoKRG8geW91IHBsYW4gdG8gdGFrZSB0aGlzIHVwc3RyZWFtIGZv
ciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cgb3IKc2hvdWxkIEkganVzdCBtZXJnZSB0aGlzIHBhdGNo
PwoKWW91cnMsCkxpbnVzIFdhbGxlaWoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
